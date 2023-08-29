//
//  VisitListViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

protocol VisitListViewModelProtocol {
    var delegate: VisitListViewModelDelegate? { get set }
    func visitCount() -> Int
    func fetchVisitList()
    func getVisit(at index: Int) -> PlaceVisit?
    func markImageLoaded(at index: Int)
}


protocol VisitListViewModelDelegate: AnyObject {
    func visitLoaded()
}

final class VisitListViewModel: VisitListViewModelProtocol {
    
    var numberOfRow:Int {
        guard let visit = visit?.data?.count else { return 0}
        return visit
    }
    
    weak var delegate: VisitListViewModelDelegate?
    var visit: VisitModel?
    var user: UserModel?
    
    private var loadedImagesIndexes = Set<Int>()
    
    func markImageLoaded(at index: Int) {
        loadedImagesIndexes.insert(index)
    }
    
    func fetchVisitList() {
        TravioNetwork.shared.makeRequest(request: Router.travels) { (result:Result<VisitModel, Error>) in
            switch result {
            case .success(let result):
                self.visit = result
                self.delegate?.visitLoaded()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func visitCount() -> Int {
        guard let visit = visit?.data?.count else { return 0}
        return visit
    }
    
    func getVisit(at index: Int) -> PlaceVisit? {
        guard let visit = visit?.data?.visits else { return PlaceVisit() }
        return visit[index].place
    }
}

