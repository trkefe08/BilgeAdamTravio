//
//  VisitListViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

final class VisitsViewModel {
    //MARK: - Variables
    var places:[Visit]? {
        didSet {
            getCount = places?.count
        }
    }
    
    var getCount: Int?
    //MARK: - Functions
    func fetchVisitList(callback: @escaping ()->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getAllVisits) { (result:Result<ApiResponse, Error>) in
            switch result {
            case .success(let result):
                self.places = result.data?.visits
                callback()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getPlacesIndex(at index: Int) -> Visit {
        guard let place = places?[index] else { return Visit() }
        return place
    }
    
    func getPlacesId(at index: Int) -> String {
        guard let place = places?[index].placeId else { return "" }
        return place
    }
}
