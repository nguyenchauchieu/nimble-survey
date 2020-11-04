//
//  Endpoints.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/1/20.
//

import Foundation

struct Endpoints {
    static let baseUrl = "https://survey-api.nimblehq.co/"
    
    static let loginUrl = "/api/v1/oauth/token"
    static let forgotPasswordUrl = "/api/v1/passwords"
    static let getSurveyList = "/api/v1/surveys?page[number]=1&page[size]=10"
}
