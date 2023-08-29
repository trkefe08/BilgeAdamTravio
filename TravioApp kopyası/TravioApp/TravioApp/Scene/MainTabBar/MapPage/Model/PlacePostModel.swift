//
//  PlacePostModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

// MARK: - PlacePostModel
struct PlacePostModel: Codable {
    var place, title, description: String?
    var coverImageURL: String?
    var latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case place, title, description
        case coverImageURL = "cover_image_url"
        case latitude, longitude
    }
}
