//
//  PopularPlacesViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 8.09.2023.
//
import Foundation

final class PopularPlacesVM {
    //MARK: - Variables
    var sortedmyArrayAtoZ:[MyAddedPlace] = []
    var sortedmyArrayZtoA:[MyAddedPlace] = []
    //MARK: - Functions
    func fetchPopularPlaces(limit: Int, completion: @escaping ()->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getPopularPlaces(limit: limit)) { (result:Result<MyAddedResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.sortedmyArrayAtoZ = result.data.places.sorted {
                        $0.title.localizedCompare($1.title) == .orderedAscending
                    }
                    self.sortedmyArrayZtoA = result.data.places.sorted {
                        $0.title.localizedCompare($1.title) == .orderedDescending
                    }
                    completion()
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
}

