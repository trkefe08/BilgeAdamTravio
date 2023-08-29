//
//  RegisterModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

struct RegisterModel: Codable {
    var fullName, email, password: String?
    var message, status: String?
   

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email, password, message, status
    }
}

struct UserResponse: Codable {
    var accessToken, refreshToken: String?
}

struct UserModel: Codable {
    var fullName, email, role: String?
   

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email, role
    }
}
