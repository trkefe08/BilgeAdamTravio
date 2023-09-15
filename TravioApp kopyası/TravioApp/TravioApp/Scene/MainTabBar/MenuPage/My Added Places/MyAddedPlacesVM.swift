//
//  MyAddedPlacesVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 4.09.2023.
//

import Foundation

final class MyAddedPlacesVM {
    //MARK: - Variables
    var isButtonActive = false
    var sortedmyArrayAtoZ:[MyAddedPlace] = []
    var sortedmyArrayZtoA:[MyAddedPlace] = []
    //MARK: - Functions
    func getAllPlacesForUser(callback: @escaping (String?)->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getAllPlacesForUser) { (result:Result<MyAddedResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.sortedmyArrayAtoZ = result.data.places.sorted {
                        $0.title.localizedCompare($1.title) == .orderedAscending
                    }
                    self.sortedmyArrayZtoA = result.data.places.sorted {
                        $0.title.localizedCompare($1.title) == .orderedDescending
                    }
                    callback(nil)
                case .failure(let err):
                    callback(err.localizedDescription)
                }
            }
        }
    }
}
