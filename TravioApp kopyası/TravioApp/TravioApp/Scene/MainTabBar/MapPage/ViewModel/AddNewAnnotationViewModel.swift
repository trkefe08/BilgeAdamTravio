//
//  AddNewAnnotationViewModel.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation
import Alamofire

protocol AddNewAnnotationProtocol {
    var delegate: AddNewAnnotationDelegate? { get set }
    func postNewPlace(params: Parameters)
    
}


protocol AddNewAnnotationDelegate: AnyObject {
    func mapLocationsLoaded()
}

class AddNewAnnotationViewModel: AddNewAnnotationProtocol {
    
    weak var delegate: AddNewAnnotationDelegate?
    
    func postNewPlace(params: Parameters) {
        TravioNetwork.shared.makeRequest(request: Router.place(Parameters: params)) { (result: Result<PlacePostModel, Error>) in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
}

