//
//  PopularPlacesModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 6.09.2023.
//

import Foundation

struct PopularPlacesModel: Codable {
    var data: DataPopular?
    var status: String?
}

// MARK: - DataClass
struct DataPopular: Codable {
    var count: Int?
    var places: [PopularPlace]?
}

// MARK: - Place
struct PopularPlace: Codable {
    var id, creator, place, title: String?
    var description: String?
    var coverImageURL: String?
    var latitude, longitude: Double?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, creator, place, title, description
        case coverImageURL = "cover_image_url"
        case latitude, longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
