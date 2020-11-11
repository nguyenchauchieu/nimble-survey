//
//  RequestInterceptor.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/9/20.
//

import Foundation
import Alamofire

class NimbleRequestInterceptor: RequestInterceptor {
  //1
  let retryLimit = 3
  let retryDelay: TimeInterval = 10
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if request.response?.statusCode == 401 {
            if let refreshToken = LoggedUserInfo.getRefreshToken() {
                APIClient.shared.refreshToken(refreshToken: refreshToken) {
                    completion(.retry)
                } failure: { (errorMessage) in
                    completion(.doNotRetry)
                }
            }
        }
    }
}
