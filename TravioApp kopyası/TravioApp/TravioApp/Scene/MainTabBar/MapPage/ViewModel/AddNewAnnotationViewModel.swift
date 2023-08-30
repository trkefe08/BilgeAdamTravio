//
//  AddNewAnnotationViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation
import Alamofire

protocol AddNewAnnotationProtocol {
    var delegate: AddNewAnnotationDelegate? { get set }
    func postNewPlace(params: Parameters, completion: @escaping (String?) -> Void)
    func upload(image: [Data], completion: @escaping ([String]?) -> Void)
    
}


protocol AddNewAnnotationDelegate: AnyObject {
    func mapLocationsLoaded()
}

class AddNewAnnotationViewModel: AddNewAnnotationProtocol {
    
    weak var delegate: AddNewAnnotationDelegate?
    var upload: UploadModel?
    var place: PlacePostModel?
    var uploadImageUrls: [String] = []
    // FIXME: Burası
    func postNewPlace(params: Parameters, completion: @escaping (String?) -> Void) {
        TravioNetwork.shared.makeRequest(request: Router.place(parameters: params)) { (result: Result<PlacePostModel, Error>) in
            switch result {
            case .success(let success):
                self.place = success
                completion(success.message)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    // FIXME: Burası
    func upload(image: [Data], completion: @escaping ([String]?) -> Void) {
        TravioNetwork.shared.uploadImage(route: .upload(image: image)) { (result: Result<UploadModel, Error>) in
            switch result {
            case .success(let response):
                self.uploadImageUrls = response.urls ?? []
                completion(response.urls)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    // FIXME: Burası düzeltilmeli
    func postGallery(params: Parameters) {
        TravioNetwork.shared.makeRequest(request: Router.postGallery(parameters: params)) { (result: Result<UploadModel, Error>) in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    
    
}

