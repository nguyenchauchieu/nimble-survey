//
//  ResponseErrors.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/4/20.
//

import Foundation
public struct ResponseErrors: Codable {
    var errors: [ResponseError] = [ResponseError]()
    func getErrorsString() -> String {
        var errorString = ""
        for index in 0...errors.count - 1 {
            errorString += errors[index].detail + "\n"
        }
        return errorString
    }
}
