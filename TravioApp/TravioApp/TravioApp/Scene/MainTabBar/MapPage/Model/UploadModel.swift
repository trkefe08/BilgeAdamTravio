//
//  UploadModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

// MARK: - UploadModel
struct UploadModel: Codable {
    var messageType, message: String?
    var urls: [String]?
}
