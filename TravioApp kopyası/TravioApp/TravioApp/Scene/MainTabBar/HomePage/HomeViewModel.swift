//
//  HomeViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 6.09.2023.
//

import Foundation

class HomeViewModel {
    
    func fetchPopularPlaces(limit: Int, completion: @escaping (PopularPlacesModel) -> Void) {
        TravioNetwork.shared.makeRequest(request: Router.getPopularPlaces(limit: 5)) { (result: Result<PopularPlacesModel, Error>) in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func fetchLastPlaces(limit: Int, completion: @escaping(PopularPlacesModel) -> Void) {
        TravioNetwork.shared.makeRequest(request: Router.getLastPlaces(limit: limit)) { (result: Result<PopularPlacesModel, Error>) in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func fetchVisits() {
        
    }
}
