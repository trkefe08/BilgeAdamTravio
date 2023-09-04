//
//  MyAddedPlacesVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 4.09.2023.
//

import Foundation

class MyAddedPlacesVM {
    
    var sortedmyArrayAtoZ:[MyAddedPlace] = []
    var sortedmyArrayZtoA:[MyAddedPlace] = []
    
    func getAllPlacesForUser(callback: @escaping ()->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getAllPlacesForUser) { (result:Result<MyAddedResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.sortedmyArrayAtoZ = result.data.places.sorted { $0.title < $1.title }
                    self.sortedmyArrayZtoA = result.data.places.sorted { $1.title < $0.title }
                    callback()
                case .failure(let err):
                    print(err.localizedDescription)
                    callback()
                }
            }
        }
    }
}
