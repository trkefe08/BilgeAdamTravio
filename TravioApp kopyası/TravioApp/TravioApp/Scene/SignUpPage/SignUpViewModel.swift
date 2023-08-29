//
//  SignUpViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

import Foundation


class SignUpViewModel {
//    func signUp(params: [String:String]) {
//
//        TravioNetwork.shared.objectRequest(from: Constant.BASE_URL + Constant.REGISTER, params: params, method: .post) { (result:Result<RegisterModel,Error>) in
//            switch result {
//            case .success(let value):
//                print(value)
//
//            case .failure(let err):
//                print(Constant.BASE_URL + Constant.REGISTER)
//                print(err.localizedDescription)
//            }
//        }
//    }
    
    func signUp2(params: [String:String]) {
        
        TravioNetwork.shared.makeRequest(request: Router.register(parameters: params)) { (result:Result<RegisterModel,Error>) in
            switch result {
            case .success(let value):
                print(value)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
