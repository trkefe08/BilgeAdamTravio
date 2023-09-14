//
//  LoginM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 30.08.2023.
//

import Foundation
//MARK: - LoginInfo
struct LoginInfo: Codable {
    var email: String
    var password: String
}
//MARK: - LoginReturn
struct LoginReturn: Codable {
    var accessToken: String
    var refreshToken: String
}
