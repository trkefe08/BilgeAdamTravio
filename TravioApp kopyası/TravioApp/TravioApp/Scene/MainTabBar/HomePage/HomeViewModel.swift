//
//  HomeViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 6.09.2023.
//

import Foundation

class HomeViewModel {
    
    func fetchPopularPlaces(limit: Int, completion: @escaping (MapModel) -> Void) {
        TravioNetwork.shared.makeRequest(request: Router.getPopularPlaces(limit: 5)) { (result: Result<MapModel, Error>) in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func fetchLastPlaces(limit: Int, completion: @escaping(MapModel) -> Void) {
        TravioNetwork.shared.makeRequest(request: Router.getLastPlaces(limit: limit)) { (result: Result<MapModel, Error>) in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func fetchVisits(page: Int, limit: Int, completion: @escaping(ApiResponse) -> Void) {
        TravioNetwork.shared.makeRequest(request: Router.getAllVisitsLimit(page: page, limit: limit)) { (result: Result<ApiResponse, Error>) in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
