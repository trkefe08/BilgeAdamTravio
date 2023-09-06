//
//  VisitModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

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
    let place: Place
    
    enum CodingKeys: String, CodingKey {
        case id
        case placeId = "place_id"
        case visitedAt = "visited_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case place
    }
}

