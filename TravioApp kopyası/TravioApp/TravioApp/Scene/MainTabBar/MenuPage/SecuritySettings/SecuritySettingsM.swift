//
//  SecuritySettingsM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 6.09.2023.
//

import Foundation
//MARK: - PasswordChangeRequest
struct PasswordChangeRequest: Codable {
    let new_password: String
}
//MARK: - PasswordChangeResponse
struct PasswordChangeResponse: Codable {
    let message: String
    let status: String
}
