//
//  MyVisitsViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 8.09.2023.
//

import Foundation

final class MyVisitsViewModel {
    //MARK: - Variables
    var sortedmyArrayAtoZ:[Visit] = []
    var sortedmyArrayZtoA:[Visit] = []
    //MARK: - Functions
    func fetchMyVisits(page: Int, limit: Int, completion: @escaping ()->Void) {
        TravioNetwork.shared.makeRequest(request: Router.getAllVisitsLimit(page: page, limit: limit)) { (result:Result<ApiResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.sortedmyArrayAtoZ = result.data.visits.sorted {
                        guard let first = $0.place.title, let second = $1.place.title else {
                            return false
                        }
                        return first < second
                    }
                    self.sortedmyArrayZtoA = result.data.visits.sorted {
                        guard let first = $0.place.title, let second = $1.place.title else {
                            return false
                        }
                        return second < first
                    }
                    completion()
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
}
