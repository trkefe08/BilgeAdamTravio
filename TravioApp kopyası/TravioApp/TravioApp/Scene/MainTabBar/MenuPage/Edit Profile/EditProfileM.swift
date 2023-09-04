//
//  EditProfileM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 4.09.2023.
//

import Foundation

struct EditProfileModel: Codable {
    let fullName: String
    let email: String
    let role: String
    let ppUrl: URL
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email
        case role
        case ppUrl = "pp_url"
        case createdAt = "created_at"
    }
}
