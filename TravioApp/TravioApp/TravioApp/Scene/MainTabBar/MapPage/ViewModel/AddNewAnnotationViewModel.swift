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
    func postGallery(params: Parameters)
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
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func upload(image: [Data?], completion: @escaping ([String]?) -> Void) {
        TravioNetwork.shared.uploadImage(route: .upload(image: image)) { (result: Result<UploadModel, Error>) in
            switch result {
            case .success(let response):
                completion(response.urls)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func postGallery(params: Parameters) {
        TravioNetwork.shared.makeRequest(request: Router.postGallery(parameters: params)) { (result: Result<ResponseModel, Error>) in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
}

