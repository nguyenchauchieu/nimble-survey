//
//  APIClient.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/1/20.
//
import Alamofire
import Foundation

public typealias FailureResponse = (ResponseErrors?) -> Void
public typealias SuccessResponse = (Data?) -> Void

class APIClient: NSObject {
    
    static let shared = APIClient()
    
    func login(email: String, password: String, success: @escaping (LoggedUserInfo?) -> Void, failure: @escaping FailureResponse) {
        var parameters = [String: Any?]()
        parameters["grant_type"] = "password"
        parameters["email"] = email
        parameters["password"] = password
        parameters["client_id"] = Constants.clienId
        parameters["client_secret"] = Constants.clientSecret
        let headers = HTTPHeaders()
        let request = AF.request(Endpoints.baseUrl + Endpoints.loginUrl, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil)
        request.validate().response { (response) in
            switch response.result {
            case .success( _):
                if let data = response.data {
                    let loggedUserInfo = try? JSONDecoder().decode(LoggedUserInfo.self, from: data)
                    let loggedUserInfoData = try? JSONEncoder().encode(loggedUserInfo)
                    UserDefaults.standard.set(loggedUserInfoData, forKey: Constants.UserDefaultKeys.loggedUserInfo)
                    success(loggedUserInfo)
                } else {
                    failure(ResponseErrors(errors: [ResponseError]()))
                }
            case .failure( _):
                if let data = response.data {
                    let jsonDecoder = JSONDecoder()
                    let errors = try? jsonDecoder.decode(ResponseErrors.self, from: data)
                    failure(errors)
                } else {
                    failure(ResponseErrors(errors: [ResponseError]()))
                }
            }
        }
    }
    
    func refreshToken(refreshToken: String, success: @escaping (LoggedUserInfo?) -> Void, failure: @escaping FailureResponse) {
        var parameters = [String: Any?]()
        parameters["grant_type"] = "refresh_token"
        parameters["refresh_token"] = refreshToken
        parameters["client_id"] = Constants.clienId
        parameters["client_secret"] = Constants.clientSecret
        let headers = HTTPHeaders()
        let request = AF.request(Endpoints.baseUrl + Endpoints.loginUrl, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil)
        request.validate().response { (response) in
            switch response.result {
            case .success( _):
                if let data = response.data {
                    let loggedUserInfo = try? JSONDecoder().decode(LoggedUserInfo.self, from: data)
                    let loggedUserInfoData = try? JSONEncoder().encode(loggedUserInfo)
                    UserDefaults.standard.set(loggedUserInfoData, forKey: Constants.UserDefaultKeys.loggedUserInfo)
                    success(loggedUserInfo)
                } else {
                    failure(ResponseErrors(errors: [ResponseError]()))
                }
            case .failure( _):
                if let data = response.data {
                    let jsonDecoder = JSONDecoder()
                    let errors = try? jsonDecoder.decode(ResponseErrors.self, from: data)
                    failure(errors)
                } else {
                    failure(ResponseErrors(errors: [ResponseError]()))
                }
            }
        }
    }
    
    func forgotPassword(email: String, success: @escaping () -> Void, failure: @escaping FailureResponse) {
        var parameters = [String: Any?]()
        parameters["user"] = ["email": email]
        parameters["client_id"] = Constants.clienId
        parameters["client_secret"] = Constants.clientSecret
        let headers = HTTPHeaders()
        let request = AF.request(Endpoints.baseUrl + Endpoints.forgotPasswordUrl, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil)
        request.validate().response { (response) in
            switch response.result {
            case .success( _):
                success()
            case .failure( _):
                if let data = response.data {
                    let jsonDecoder = JSONDecoder()
                    let errors = try? jsonDecoder.decode(ResponseErrors.self, from: data)
                    failure(errors)
                } else {
                    failure(ResponseErrors(errors: [ResponseError]()))
                }
            }
        }
    }
    
    func post(url : String,
              parameters: [String: Any]?,
              encoding: ParameterEncoding,
              success: @escaping SuccessResponse,
              failure: @escaping FailureResponse) {
        execute(url: url, parameters: parameters, method: .post, encoding: encoding, success: success, failure: failure)
    }
    
    func get(url : String,
             parameters: [String: Any]?,
             encoding: ParameterEncoding,
             success: @escaping SuccessResponse,
             failure: @escaping FailureResponse) {
        execute(url: url, parameters: parameters, method: .get, encoding: encoding, success: success, failure: failure)
    }
    
    fileprivate func execute(url : String,
                             parameters: [String: Any]?,
                             method: HTTPMethod,
                             encoding: ParameterEncoding,
                             success: @escaping SuccessResponse,
                             failure: @escaping FailureResponse) {
        var headers = HTTPHeaders()
        if let savedData = UserDefaults.standard.object(forKey: Constants.UserDefaultKeys.loggedUserInfo) as? Data, let loggedUserInfo = try? JSONDecoder.init().decode(LoggedUserInfo.self, from: savedData) {
            headers.add(name: "Authorization", value: "Bearer" + " " + loggedUserInfo.accessToken)
        }
        let request = AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: nil, requestModifier: nil)
        request.validate().response { (response) in
            switch response.result {
            case .success( _):
                success(response.data)
            case .failure( _):
                if response.response?.statusCode == 401 {
                    if let savedData = UserDefaults.standard.object(forKey: Constants.UserDefaultKeys.loggedUserInfo) as? Data, let loggedUserInfo = try? JSONDecoder.init().decode(LoggedUserInfo.self, from: savedData) {
                        self.refreshToken(refreshToken: loggedUserInfo.refreshToken) { (response) in
                            
                        } failure: { (errorMessage) in
                            
                        }
                        
                    }
                } else {
                    if let data = response.data {
                        let jsonDecoder = JSONDecoder()
                        let errors = try? jsonDecoder.decode(ResponseErrors.self, from: data)
                        failure(errors)
                    } else {
                        failure(ResponseErrors(errors: [ResponseError]()))
                    }
                    
                }
            }
        }
    }
}
