//
//  LoginViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

final class LoginViewModel {
    //MARK: - Functions
    func login(params: [String: Any], callback: @escaping (Error?) -> Void) {
        TravioNetwork.shared.makeRequest(request: Router.login(parameters: params)) { (result: Result<LoginReturn, Error>) in
            switch result {
            case .success(let value):
                let data = Data(value.accessToken.utf8)
                KeyChainHelper.shared.save(data, service: "access_token", account: "bilgeadam")
                callback(nil)
            case .failure(let err):
                callback(err)
            }
        }
    }
}
