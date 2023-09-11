//
//  MapViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation
import Alamofire
import MapKit

//MARK: - Protocol
protocol MapViewModelProtocol {
    var delegate: MapViewModelDelegate? { get set }
    func fetchPlaces(completion: @escaping (() -> Void))
    func getMapInfo() -> [Place]
    func getMapCollectionDetails(at index: Int) -> Place?
    func getMapCollectionCount() -> Int
    func getIndexForAnnotation(_ annotation: MKPointAnnotation) -> Int?
    func checkVisit(id: String, completion: @escaping((String?) -> Void))
    func getMapCollectionId(at index: Int) -> String?
}

protocol MapViewModelDelegate: AnyObject {
    func mapLocationsLoaded()
}

//MARK: - Class
class MapViewModel: MapViewModelProtocol {
    
    //MARK: - Variables
    weak var delegate: MapViewModelDelegate?
    var places: MapModel?
    private var loadedImagesIndexes = Set<Int>()
    
    //MARK: - Functions
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
    
    func checkVisit(id: String, completion: @escaping((String?) -> Void)) {
        TravioNetwork.shared.makeRequest(request: Router.checkVisitByPlaceId(id: id)) { (result:Result<ResponseCheckModel, Error>) in
            switch result {
            case .success(let result):
                completion(result.status)
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
    
    func getMapCollectionId(at index: Int) -> String? {
        guard let collection = places?.data?.places else { return "" }
        return collection[index].id
    }
    
    func getMapCollectionCount() -> Int {
        guard let count = places?.data?.count else { return 0 }
        return count
    }
    
    func getIndexForAnnotation(_ annotation: MKPointAnnotation) -> Int? {
        let locations = getMapInfo()
        
        for (index, location) in locations.enumerated() {
            if location.latitude == annotation.coordinate.latitude &&
                location.longitude == annotation.coordinate.longitude {
                return index
            }
        }
        return nil
    }
    
}
