//
//  TravioNetwork.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation
import Alamofire


final class TravioNetwork {
    
    static let shared = TravioNetwork()
    private init() {}
    
    func makeRequest<T: Codable>(request: URLRequestConvertible, callback: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(request).validate(statusCode: 200..<501).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                    callback(.success(decodedData))
                } catch {
                    callback(.failure(error))
                }
            case .failure(let err):
                callback(.failure(err))
            }
        }
    }
    
    func uploadImage<T: Codable>(route:Router, callback: @escaping (Result<T, Error>) -> Void) {
        
        let request: URLRequestConvertible = route
        
        AF.upload(multipartFormData: route.multipartFormData, with: request)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        callback(.success(decodedData))
                    } catch {
                        callback(.failure(error))
                    }
                case .failure(let error):
                    callback(.failure(error))
                }
            }
    }
}

func objectRequest<T: Codable>(from apiUrl: String, params: Parameters = [:], method: HTTPMethod, requiresAuthorization: Bool = false, callback: @escaping (Result<T, Error>) -> Void) {
    var headers: HTTPHeaders = [:]
    if requiresAuthorization {
        guard let data = KeyChainHelper.shared.read(service: "access_token", account: "bilgeadam") else {
            return
        }
        guard let token = String(data: data, encoding: .utf8) else {
            return
        }
        headers["Authorization"] = "Bearer \(token)"
    }
    
    let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
    
    AF.request(apiUrl,
               method: method,
               parameters: params,
               encoding: encoding,
               headers: headers).validate().responseJSON { response in
        
        switch response.result {
        case .success(let value):
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                callback(.success(decodedData))
            } catch {
                callback(.failure(error))
            }
        case .failure(let err):
            callback(.failure(err))
        }
    }
}



