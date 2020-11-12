//
//  SurveyService.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/3/20.
//

import Foundation
import Alamofire
class SurveyService {
    func getSurveys(completion: @escaping ([Survey]) -> Void, failure: @escaping FailureResponse) {
        APIClient.shared.get(url: Endpoints.baseUrl + Endpoints.getSurveyList,
                             parameters: nil,
                             encoding: JSONEncoding.default) { (result) in
            let jsonDecoder = JSONDecoder()
            if let result = result, let surveyResponse = try? jsonDecoder.decode(SurveysResponseModel.self, from: result) {
                self.cacheSurveys(surveys: surveyResponse.data)
                completion(surveyResponse.data)
            }
        } failure: { (errorMessage) in
            let jsonDecoder = JSONDecoder()
            if let cachedData = UserDefaults.standard.object(forKey: Constants.UserDefaultKeys.cachedSurveys) as? Data,
               let cachedSurveys = try? jsonDecoder.decode([Survey].self, from: cachedData) {
                completion(cachedSurveys)
            } else {
                failure(errorMessage)
            }
        }
    }
    
    private func cacheSurveys(surveys: [Survey]) {
        let jsonEncoder = JSONEncoder()
        if let surveyListData = try? jsonEncoder.encode(surveys) {
            UserDefaults.standard.set(surveyListData, forKey: Constants.UserDefaultKeys.cachedSurveys)
        }
    }
}
