//
//  VisitGalleryModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

// MARK: - VisitGallerylModel
struct VisitGalleryModel: Codable {
    var data: DataGallery?
    var status: String?
}

// MARK: - DataClass
struct DataGallery: Codable {
    var count: Int?
    var images: [Image]?
}

// MARK: - Image
struct Image: Codable {
    var id, travelID: String?
    var imageURL: String?
    var caption, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case travelID = "travel_id"
        case imageURL = "image_url"
        case caption
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
