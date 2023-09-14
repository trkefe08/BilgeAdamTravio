//
//  LoginM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 30.08.2023.
//

import Foundation

struct LoginInfo: Codable {
    var email: String
    var password: String
}

struct LoginReturn: Codable {
    var accessToken: String
    var refreshToken: String
}
