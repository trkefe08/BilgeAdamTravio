//
//  HomeViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 6.09.2023.
//

import Foundation

final class HomeViewModel {
    //MARK: - Functions
    func fetchPopularPlaces(limit: Int, completion: @escaping (MapModel?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            TravioNetwork.shared.makeRequest(request: Router.getPopularPlaces(limit: 5)) { (result: Result<MapModel, Error>) in
                switch result {
                case .success(let result):
                    completion(result)
                case .failure(_):
                    completion(nil)
                }
            }
        }
    }
    
    func fetchLastPlaces(limit: Int, completion: @escaping(MapModel?) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            TravioNetwork.shared.makeRequest(request: Router.getLastPlaces(limit: limit)) { (result: Result<MapModel, Error>) in
                switch result {
                case .success(let result):
                    completion(result)
                case .failure(_):
                    completion(nil)
                }
            }
        }
    }
    
    func fetchVisits(page: Int, limit: Int, completion: @escaping(ApiResponse?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            TravioNetwork.shared.makeRequest(request: Router.getAllVisitsLimit(page: page, limit: limit)) { (result: Result<ApiResponse, Error>) in
                switch result {
                case .success(let result):
                    completion(result)
                case .failure(_):
                    completion(nil)
                }
            }
        }
    }
}
