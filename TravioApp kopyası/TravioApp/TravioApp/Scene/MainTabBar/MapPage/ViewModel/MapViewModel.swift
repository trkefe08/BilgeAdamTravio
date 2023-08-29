//
//  MapViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation
import Alamofire

protocol MapViewModelProtocol {
    var delegate: MapViewModelDelegate? { get set }
    func fetchPlaces(completion: @escaping (() -> Void))
    func getMapInfo() -> [Place]
    func getMapCollectionDetails(at index: Int) -> Place?
    func getMapCollectionCount() -> Int
    func markImageLoaded(at index: Int)
    
}


protocol MapViewModelDelegate: AnyObject {
    func mapLocationsLoaded()
}

class MapViewModel: MapViewModelProtocol {
    
    weak var delegate: MapViewModelDelegate?
    var places: MapModel?
    
    private var loadedImagesIndexes = Set<Int>()
    
    func markImageLoaded(at index: Int) {
        loadedImagesIndexes.insert(index)
    }
    
    func fetchPlaces(completion: @escaping (() -> Void)) {
        TravioNetwork.shared.makeRequest(request: Router.places) {
            (result:Result<MapModel, Error>) in
            switch result {
            case .success(let result):
                self.places = result
                self.delegate?.mapLocationsLoaded()
                completion()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func getMapInfo() -> [Place] {
        guard let latitude = places?.data?.places else { return [Place]() }
        return latitude
    }
    
    func getMapCollectionDetails(at index: Int) -> Place? {
        guard let collection = places?.data?.places else { return Place() }
        return collection[index]
    }
    
    func getMapCollectionCount() -> Int {
        guard let count = places?.data?.count else { return 0 }
        return count
    }
    
}
