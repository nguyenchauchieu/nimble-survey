//
//  LoggedUserInfo.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/1/20.
//

import Foundation

struct LoggedUserInfo: Encodable, Decodable {
    
    enum LoggedUserInfoKeys: String, CodingKey {
        case data = "data"
    }

    enum LoggedUserInfoDataKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case attributes = "attributes"
    }

    enum LoggedUserInfoAttributesKeys: String, CodingKey {
        case accessToken = "access_token"
        case token_type = "token_type"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
        case expiresIn = "expires_in"
    }
    
    var accessToken: String = ""
    var refreshToken: String = ""
    var createdAt: Int = 0
    var expiredIn: Int = 0
    
    init(from decoder: Decoder) throws {
        let loggedUserInfoContainer = try decoder.container(keyedBy: LoggedUserInfoKeys.self)
        let loggedUserInfoDataContainer = try loggedUserInfoContainer.nestedContainer(keyedBy: LoggedUserInfoDataKeys.self, forKey: .data)
        let loggedUserInfoAttributeContainer = try loggedUserInfoDataContainer.nestedContainer(keyedBy: LoggedUserInfoAttributesKeys.self, forKey: .attributes)
        
        accessToken = try loggedUserInfoAttributeContainer.decode(String.self, forKey: .accessToken)
        refreshToken = try loggedUserInfoAttributeContainer.decode(String.self, forKey: .refreshToken)
        createdAt = try loggedUserInfoAttributeContainer.decode(Int.self, forKey: .createdAt)
        expiredIn = try loggedUserInfoAttributeContainer.decode(Int.self, forKey: .expiresIn)
    }
    
    func encode(to encoder: Encoder) throws {
        var loggedUserInfoContainer = encoder.container(keyedBy: LoggedUserInfoKeys.self)
        var loggedUserInfoDataContainer = loggedUserInfoContainer.nestedContainer(keyedBy: LoggedUserInfoDataKeys.self, forKey: .data)
        var loggedUserInfoAttributeContainer = loggedUserInfoDataContainer.nestedContainer(keyedBy: LoggedUserInfoAttributesKeys.self, forKey: .attributes)
        
        try loggedUserInfoAttributeContainer.encode(accessToken, forKey: .accessToken)
        try loggedUserInfoAttributeContainer.encode(refreshToken, forKey: .refreshToken)
        try loggedUserInfoAttributeContainer.encode(createdAt, forKey: .createdAt)
        try loggedUserInfoAttributeContainer.encode(expiredIn, forKey: .expiresIn)
    }
    
    static func saveAccessToken(_ accessToken: String) {
        KeychainWrapper.standard.set(accessToken, forKey: Constants.KeychainKeys.accessToken)
    }
    
    static func saveRefreshToken(_ refreshToken: String) {
        KeychainWrapper.standard.set(refreshToken, forKey: Constants.KeychainKeys.refreshToken)
    }
    
    static func getAccessToken() -> String? {
        let accessToken = KeychainWrapper.standard.string(forKey: Constants.KeychainKeys.accessToken)
        return accessToken
    }
    
    static func getRefreshToken() -> String? {
        let refreshToken = KeychainWrapper.standard.string(forKey: Constants.KeychainKeys.refreshToken)
        return refreshToken
    }
}
