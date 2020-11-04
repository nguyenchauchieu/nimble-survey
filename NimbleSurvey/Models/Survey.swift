//
//  Survey.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/3/20.
//

import Foundation
struct Survey: Encodable, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case attributes
    }
    
    enum AttributeCodingKeys: String, CodingKey {
        case title
        case description
        case isActive = "is_active"
        case imageUrl = "cover_image_url"
        case createAt = "created_at"
        case surveyType = "survey_type"
    }
    
    var id: String = ""
    var title: String = ""
    var description: String = ""
    var isActive: Bool = false
    var imageUrl: String = ""
    var createAt: Date = Date()
    var surveyType: String = ""

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        let attributeContainer = try container.nestedContainer(keyedBy: AttributeCodingKeys.self, forKey: .attributes)
        title = try attributeContainer.decode(String.self, forKey: .title)
        description = try attributeContainer.decode(String.self, forKey: .description)
        isActive = try attributeContainer.decode(Bool.self, forKey: .isActive)
        imageUrl = try attributeContainer.decode(String.self, forKey: .imageUrl)
        surveyType = try attributeContainer.decode(String.self, forKey: .surveyType)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        var attributeContainer = container.nestedContainer(keyedBy: AttributeCodingKeys.self, forKey: .attributes)
        try attributeContainer.encode(title, forKey: .title)
        try attributeContainer.encode(description, forKey: .description)
        try attributeContainer.encode(isActive, forKey: .isActive)
        try attributeContainer.encode(imageUrl, forKey: .imageUrl)
        try attributeContainer.encode(surveyType, forKey: .surveyType)
    }
}
