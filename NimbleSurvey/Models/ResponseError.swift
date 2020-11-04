//
//  ResponseError.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/4/20.
//

import Foundation
public struct ResponseError: Codable {
    var source: String = ""
    var detail: String = ""
    var code: String = ""
}
