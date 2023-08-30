//
//  VisitModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

struct PlaceResponse: Codable {
    let data: PlaceDataResponse
    let status: String
}

struct PlaceDataResponse: Codable {
    let count: Int
    let places: [PlaceDetailResponse]
}

struct PlaceDetailResponse: Codable {
    let id: String
    let creator: String
    let place: String
    let title: String
    let description: String
    let coverImageURL: String
    let latitude: Double
    let longitude: Double
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, creator, place, title, description
        case coverImageURL = "cover_image_url"
        case latitude, longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    
    }
}
