//
//  AddNewAnnotationViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation
import Alamofire
//MARK: - Protocol
protocol AddNewAnnotationProtocol {
    func postNewPlace(params: Parameters, completion: @escaping (String?) -> Void)
    func upload(image: [Data?], completion: @escaping ([String]?) -> Void)
    func postGallery(params: Parameters, completion: @escaping (String?) -> Void)
}

//MARK: - Class
final class AddNewAnnotationViewModel: AddNewAnnotationProtocol {
    //MARK: - Variables
    var upload: UploadModel?
    var place: ResponseModel?
    
    //MARK: - Functions
    func postNewPlace(params: Parameters, completion: @escaping (String?) -> Void) {
        TravioNetwork.shared.makeRequest(request: Router.place(parameters: params)) { (result: Result<ResponseModel, Error>) in
            switch result {
            case .success(let success):
                self.place = success
                completion(success.message)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func upload(image: [Data?], completion: @escaping ([String]?) -> Void) {
        TravioNetwork.shared.uploadImage(route: .upload(image: image)) { (result: Result<UploadModel, Error>) in
            switch result {
            case .success(let response):
                completion(response.urls)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func postGallery(params: Parameters, completion: @escaping (String?) -> Void) {
        TravioNetwork.shared.makeRequest(request: Router.postGallery(parameters: params)) { (result: Result<ResponseModel, Error>) in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let err):
                completion(err.localizedDescription)
            }
        }
        
    }
}

