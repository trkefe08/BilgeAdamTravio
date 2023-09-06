//
//  VisitListViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

class VisitsViewModel {
    var places:[Visit]?
    
    func fetchVisitList(callback: @escaping (ApiResponse)->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getAllVisits) { (result:Result<ApiResponse, Error>) in
            switch result {
            case .success(let result):
                print("başarılı")
                self.places = result.data.visits
                callback(result)
            case .failure(let err):
                print("başarılı")
                print(err.localizedDescription)
            }
        }
    }
}
