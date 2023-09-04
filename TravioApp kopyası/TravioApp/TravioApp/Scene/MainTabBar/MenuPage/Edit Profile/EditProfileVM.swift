//
//  EditProfileVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 4.09.2023.
//

import Foundation

class EditProfileViewModel {
    
    var data : EditProfileModel?
    
    func getProfile(callback: @escaping ()->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getProfile) { (result:Result<EditProfileModel, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.data = result
                    callback()
                case .failure(let err):
                    print(err.localizedDescription)
                    callback()
                }
            }
        }
    }
}
