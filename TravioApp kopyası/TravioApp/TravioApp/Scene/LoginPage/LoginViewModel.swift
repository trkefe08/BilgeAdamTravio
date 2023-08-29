//
//  LoginViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

class LoginViewModel {
    
    func login(params: [String:Any]) {
        
        TravioNetwork.shared.makeRequest(request: Router.login(parameters: params)) { (result:Result<UserResponse,Error>) in
            switch result {
            case .success(let value):
                print(value)
                let data = Data((value.accessToken?.utf8)!)
                KeyChainHelper.shared.save(data, service: "access_token", account: "bilgeadam")
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
