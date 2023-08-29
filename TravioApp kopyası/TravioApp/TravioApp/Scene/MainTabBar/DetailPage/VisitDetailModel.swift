//
//  VisitDetailModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

// MARK: - VisitDetailModel
struct VisitDetailModel: Codable {
    var data: DataDetail?
    var status: String?
}

// MARK: - DataClass
struct DataDetail: Codable {
    var visit: VisitDetail?
}

// MARK: - Visit
struct VisitDetail: Codable {
    var id, placeID, visitedAt, createdAt: String?
    var updatedAt: String?
    var place: PlaceDetail?

    enum CodingKeys: String, CodingKey {
        case id
        case placeID = "place_id"
        case visitedAt = "visited_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case place
    }
}

// MARK: - Place
struct PlaceDetail: Codable {
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
