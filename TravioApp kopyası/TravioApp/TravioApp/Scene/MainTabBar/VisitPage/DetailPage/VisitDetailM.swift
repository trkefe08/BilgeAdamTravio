//
//  VisitDetailM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 31.08.2023.
//

import Foundation

// İmageları almak
struct ImageResponse: Codable {
    let data: ImageData
    let status: String
}

struct ImageData: Codable {
    let count: Int
    let images: [ImageDetail]
}

struct ImageDetail: Codable {
    let id: String
    let placeId: String
    let imageUrl: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case placeId = "place_id"
        case imageUrl = "image_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// Verileri almak
struct PDetailResponse: Codable {
    let data: PlaceData
    let status: String
}

struct PlaceData: Codable {
    let place: Place2
}

struct Place2: Codable {
    let id: String
    let creator: String
    let place: String
    let title: String
    let description: String
    let coverImageUrl: String
    let latitude: Double
    let longitude: Double
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, creator, place, title, description
        case coverImageUrl = "cover_image_url"
        case latitude, longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
