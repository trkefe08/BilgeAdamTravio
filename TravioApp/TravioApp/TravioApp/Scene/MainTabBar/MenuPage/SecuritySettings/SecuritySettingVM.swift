//
//  SecuritySettingVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 6.09.2023.
//

import Foundation
import Alamofire

class SecuritySettingsVM {

    func changePassword(params: Parameters,callback: @escaping ()->Void) {
        
        TravioNetwork.shared.makeRequest(request: Router.changePassword(parameters: params)) { (result:Result<PasswordChangeResponse, Error>) in
            switch result {
            case .success:
                print("başarılı")
                callback()
            case .failure(let err):
                print("başarısız")
                print(err.localizedDescription)
                callback()
            }
        }
    }
}
