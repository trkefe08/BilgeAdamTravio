//
//  PopularPlacesViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 8.09.2023.
//
import Foundation

class PopularPlacesViewModel {
    //MARK: - Variables
    var sortedmyArrayAtoZ:[MyAddedPlace] = []
    var sortedmyArrayZtoA:[MyAddedPlace] = []
    //MARK: - Functions
    func fetchPopularPlaces(limit: Int, completion: @escaping ()->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getPopularPlaces(limit: limit)) { (result:Result<MyAddedResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.sortedmyArrayAtoZ = result.data.places.sorted { $0.title < $1.title }
                    self.sortedmyArrayZtoA = result.data.places.sorted { $1.title < $0.title }
                    completion()
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
}

