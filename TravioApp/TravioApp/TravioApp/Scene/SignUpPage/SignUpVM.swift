//
//  SignUpViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

class SignUpViewModel {

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func signUp(params: [String:Any], callback: @escaping () -> Void) {
            
            TravioNetwork.shared.makeRequest(request: Router.register(parameters: params)) { (result:Result<RegisterReturn,Error>) in
                switch result {
                case .success(let value):
                    callback()
                    print(value)
                    
                case .failure(let err):
                    print(err.localizedDescription)
                    callback()
                }
            }
        }
}
