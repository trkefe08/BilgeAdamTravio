//
//  VisitModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

//import Foundation
//
//struct PlaceResponse: Codable {
//    let data: PlaceDataResponse
//    let status: String
//}
//
//struct PlaceDataResponse: Codable {
//    let count: Int
//    let places: [PlaceDetailResponse]
//}
//
//struct PlaceDetailResponse: Codable {
//    let id: String
//    let creator: String
//    let place: String
//    let title: String
//    let description: String
//    let coverImageURL: String
//    let latitude: Double
//    let longitude: Double
//    let createdAt: String
//    let updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, creator, place, title, description
//        case coverImageURL = "cover_image_url"
//        case latitude, longitude
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//
//    }
//}


import Foundation

struct ApiResponse: Codable {
    let data: VisitData
    let status: String
}

struct VisitData: Codable {
    let count: Int
    let visits: [Visit]
}

struct Visit: Codable {
    let id: String
    let placeId: String
    let visitedAt: String
    let createdAt: String
    let updatedAt: String
    let place: PlaceList
    
    enum CodingKeys: String, CodingKey {
        case id
        case placeId = "place_id"
        case visitedAt = "visited_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case place
    }
}

struct PlaceList: Codable {
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
        case id
        case creator
        case place
        case title
        case description
        case coverImageUrl = "cover_image_url"
        case latitude
        case longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
