//
//  VisitListViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

class VisitsViewModel {
    var places:[PlaceDetailResponse]?
    
    
    func fetchVisitList(callback: @escaping (PlaceResponse)->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getAllPlacesForUser) { (result:Result<PlaceResponse, Error>) in
            switch result {
            case .success(let result):
                print("başarılı")
                self.places = result.data.places
                callback(result)
            case .failure(let err):
                print("başarılı")
                print(err.localizedDescription)
            }
        }
    }
}
