//
//  VisitDetailViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

protocol VisitDetailViewModelProtocol {
    var delegate: VisitDetailViewModelDelegate? { get set }
    func fetchDetails(id: String)
    func fetchGallery(id: String)
    func getLocationName() -> String
    func getVisitDateName() -> String
    func getInformation() -> String
    func getGallery() -> Int
    func getDetailCellConfigure(at index: Int) -> Image?
    func getMKInfo() -> [Double]
}

protocol VisitDetailViewModelDelegate: AnyObject {
    func visitDetailLoaded()
}


final class VisitDetailViewModel: VisitDetailViewModelProtocol {
    
    var visitDetail: VisitDetailModel?
    var visitGallery: VisitGalleryModel?
    weak var delegate: VisitDetailViewModelDelegate?
    
//    func fetchDetails(id: String) {
//        LoginNetwork.shared.objectRequest(from: Endpoint.travelsId(id: id).stringValue, method: .get, requiresAuthorization: true) { (result:Result<VisitDetailModel, Error>) in
//            switch result {
//            case .success(let result):
//                self.visitDetail = result
//                self.delegate?.visitDetailLoaded()
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }
    
    func fetchDetails(id: String) {
        TravioNetwork.shared.makeRequest(request: Router.travelsId(id: id)) { (result:Result<VisitDetailModel, Error>) in
            switch result {
            case .success(let result):
                self.visitDetail = result
                self.delegate?.visitDetailLoaded()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
//    func fetchGallery(id: String) {
//        LoginNetwork.shared.objectRequest(from: Endpoint.gallery(id: id).stringValue, method: .get, requiresAuthorization: true) { (result:Result<VisitGalleryModel, Error>) in
//            switch result {
//            case .success(let result):
//                self.visitGallery = result
//                self.delegate?.visitDetailLoaded()
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }
    
    func fetchGallery(id: String) {
        TravioNetwork.shared.makeRequest(request: Router.gallery(id: id)) { (result:Result<VisitGalleryModel, Error>) in
            switch result {
            case .success(let result):
                self.visitGallery = result
                self.delegate?.visitDetailLoaded()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func getLocationName() -> String {
        guard let visitLocation = visitDetail?.data?.visit?.place?.place else { return ""}
        return visitLocation
    }
    
    func getVisitDateName() -> String {
        guard let dateString = visitDetail?.data?.visit?.place?.createdAt else { return ""}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormatType.longWithoutZone.rawValue
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = FormatType.localeStandard.rawValue
            let formattedDate = outputFormatter.string(from: date)
            return formattedDate
        } else {
            return "Invalid Date"
        }
    }
    
    func getInformation() -> String {
        guard let information = visitDetail?.data?.visit?.place?.description else { return ""}
        return information
    }
    
    func getGallery() -> Int {
        guard let visitGalleryCount = visitGallery?.data?.count else { return 0}
        return visitGalleryCount
    }
    
    func getDetailCellConfigure(at index: Int) -> Image? {
        guard let cellConfigure = visitGallery?.data?.images?[index] else { return Image() }
        return cellConfigure
    }
    
    func getMKInfo() -> [Double] {
        var location: [Double] = []
        guard let latitude = visitDetail?.data?.visit?.place?.latitude else { return [Double]()}
        guard let longitude = visitDetail?.data?.visit?.place?.longitude else { return [Double]()}
        location.append(latitude)
        location.append(longitude)
        return location
    }
    

}
