//
//  VisitModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation
//MARK: - ApiResponse
struct ApiResponse: Codable {
    var data: VisitData?
    var status: String?
}
//MARK: - VisitData
struct VisitData: Codable {
    var count: Int?
    var visits: [Visit]?
}
//MARK: - Visit
struct Visit: Codable {
    var id: String?
    var placeId: String?
    var visitedAt: String?
    var createdAt: String?
    var updatedAt: String?
    var place: Place?
    
    enum CodingKeys: String, CodingKey {
        case id
        case placeId = "place_id"
        case visitedAt = "visited_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case place
    }
}

