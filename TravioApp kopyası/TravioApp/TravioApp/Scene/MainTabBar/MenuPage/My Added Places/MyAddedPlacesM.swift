//
//  MyAddedPlacesM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 4.09.2023.
//

import Foundation
//MARK: - MyAddedResponse
struct MyAddedResponse: Codable {
    let data: MyAddedPlaceData
    let status: String
}
//MARK: - MyAddedPlaceData
struct MyAddedPlaceData: Codable {
    let places: [MyAddedPlace]
}
//MARK: - MyAddedPlace
struct MyAddedPlace: Codable {
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
        case latitude, longitude, createdAt = "created_at", updatedAt = "updated_at"
    }
}
