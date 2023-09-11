//
//  SecuritySettingsM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 6.09.2023.
//

import Foundation

struct PasswordChangeRequest: Codable {
    let new_password: String
}

struct PasswordChangeResponse: Codable {
    let message: String
    let status: String
}
