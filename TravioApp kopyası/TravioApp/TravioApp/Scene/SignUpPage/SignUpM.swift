//
//  RegisterModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation
//MARK: - RegisterInfo
struct RegisterInfo: Codable {
    var full_name: String
    var email: String
    var password: String
}
//MARK: - RegisterReturn
struct RegisterReturn: Codable {
    var message: String
    var status: String
}

