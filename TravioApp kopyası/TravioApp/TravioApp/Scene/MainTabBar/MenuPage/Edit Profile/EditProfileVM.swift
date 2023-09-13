//
//  EditProfileVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 4.09.2023.
//

import Foundation
import Alamofire

class EditProfileViewModel {
    
    var oldURL:String?
    var finalURL:URL?
    var changePhotoUrl: URL?
    var data: EditProfileModel?
    var images: UploadModel?
    
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
    
    func editProfile(params: Parameters,callback: @escaping ()->Void) {
  
        TravioNetwork.shared.makeRequest(request: Router.putEditProfile(parameters: params)) { (result:Result<EditProfileResponse, Error>) in
                switch result {
                case .success:
                    callback()
                case .failure(let err):
                    print(err.localizedDescription)
                    callback()
                }
        }
    }
    
    func uploadImage(image: [Data?], completion: @escaping () -> Void) {
        TravioNetwork.shared.uploadImage(route: .upload(image: image)) { (result: Result<UploadModel, Error>) in
            switch result {
            case .success(let response):
                self.images = response
                completion()
            case .failure(let err):
                print(err.localizedDescription)
                completion()
            }
        }
    }
    
    
}
