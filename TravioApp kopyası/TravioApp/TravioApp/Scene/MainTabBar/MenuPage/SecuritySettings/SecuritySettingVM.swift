//
//  SecuritySettingVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 6.09.2023.
//

import Foundation
import Alamofire

final class SecuritySettingsVM {
    //MARK: - Functions
    func changePassword(params: Parameters,callback: @escaping (String?)->Void) {
        TravioNetwork.shared.makeRequest(request: Router.changePassword(parameters: params)) { (result:Result<PasswordChangeResponse, Error>) in
            switch result {
            case .success:
                callback(nil)
            case .failure(let err):
                callback(err.localizedDescription)
            }
        }
    }
}
