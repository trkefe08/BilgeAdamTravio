//
//  VisitDetailVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 31.08.2023.
//

import Alamofire
import Foundation
import SDWebImage

final class VisitsDetailViewModel {
    //MARK: - Variables
    var visitDetail:Place2?
    var visitGallery:ImageResponse?
    var myArray: [ImageDetail] = []
    //MARK: - Functions
    func fetchDetails(id: String, callback: @escaping (Bool?)->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getAPlaceById(id: id)) { (result:Result<PDetailResponse, Error>) in
            switch result {
            case .success(let result):
                self.visitDetail = result.data.place
            callback(true)
            case .failure(_):
                callback(nil)
            }
        }
    }
    
    func getAllGalleryByPlaceID(id: String, callback: @escaping (String?)->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getAllGalleryByPlaceID(id: id)) { (result:Result<ImageResponse, Error>) in
            switch result {
            case .success(let result):
                self.myArray = (result.data.images)
                callback(nil)
            case .failure(let err):
                callback(err.localizedDescription)
            }
        }
    }
    
    func addVisit(parameters: Parameters, completion: @escaping (String?) -> Void) {
        TravioNetwork.shared.makeRequest(request: Router.postAVisit(parameters: parameters)) { (result:Result<ResponseModel, Error>) in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let err):
                completion(err.localizedDescription)
            }
        }
    }
    
    func deleteVisit(id: String, completion: @escaping (String?) -> Void) {
        TravioNetwork.shared.makeRequest(request: Router.deleteAVisitById(id: id)) { (result:Result<ResponseModel, Error>) in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let err):
                completion(err.localizedDescription)
            }
        }
    }
    
    func checkVisit(id: String, completion: @escaping((String?) -> Void)) {
        TravioNetwork.shared.makeRequest(request: Router.checkVisitByPlaceId(id: id)) { (result:Result<ResponseCheckModel, Error>) in
            switch result {
            case .success(let result):
                completion(result.status)
            case .failure(let err):
                completion(err.localizedDescription)
            }
        }
    }
    
    func getImagesCount() -> Int{
        return myArray.count
    }
}

