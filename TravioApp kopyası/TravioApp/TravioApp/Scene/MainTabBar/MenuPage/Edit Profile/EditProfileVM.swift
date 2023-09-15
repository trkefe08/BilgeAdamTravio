//
//  EditProfileVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 4.09.2023.
//

import Foundation
import Alamofire

final class EditProfileViewModel {
    //MARK: - Variables
    var oldURL:String?
    var finalURL:URL?
    var changePhotoUrl: URL?
    var data: EditProfileModel?
    var images: UploadModel?
    //MARK: - Functions
    func getProfile(callback: @escaping (String?)->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getProfile) { (result:Result<EditProfileModel, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.data = result
                    callback(nil)
                case .failure(let err):
                    callback(err.localizedDescription)
                }
            }
        }
    }
    
    func editProfile(params: Parameters,callback: @escaping (String?)->Void) {
        TravioNetwork.shared.makeRequest(request: Router.putEditProfile(parameters: params)) { (result:Result<EditProfileResponse, Error>) in
                switch result {
                case .success:
                    callback(nil)
                case .failure(let err):
                    callback(err.localizedDescription)
            }
        }
    }
    
    func uploadImage(image: [Data?], completion: @escaping (String?) -> Void) {
        TravioNetwork.shared.uploadImage(route: .upload(image: image)) { (result: Result<UploadModel, Error>) in
            switch result {
            case .success(let response):
                self.images = response
                completion(nil)
            case .failure(let err):
                completion(err.localizedDescription)
            }
        }
    }
    
    
}
