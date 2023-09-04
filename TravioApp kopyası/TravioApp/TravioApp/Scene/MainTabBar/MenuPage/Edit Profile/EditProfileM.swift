//
//  EditProfileM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 4.09.2023.
//

import Foundation

struct ProfileInfo: Codable {
    let id: String
    let fullName: String
    let email: String
    let role: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email
        case role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
