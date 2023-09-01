//
//  VisitDetailVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 31.08.2023.
//

import Alamofire
import Foundation
import SDWebImage

class VisitsDetailViewModel {
    
    var visitDetail:Place2?
    var visitGallery:ImageResponse?
    var myArray: [ImageDetail] = []
    
    func fetchDetails(id: String, callback: @escaping (Bool)->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getAPlaceById(id: id)) { (result:Result<PDetailResponse, Error>) in
            switch result {
            case .success(let result):
                self.visitDetail = result.data.place
            callback(true)
   
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getAllGalleryByPlaceID(id: String, callback: @escaping ()->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getAllGalleryByPlaceID(id: id)) { (result:Result<ImageResponse, Error>) in
            switch result {
            case .success(let result):
                self.myArray = (result.data.images)
                callback()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getImagesCount() -> Int{
        return myArray.count
    }
}

