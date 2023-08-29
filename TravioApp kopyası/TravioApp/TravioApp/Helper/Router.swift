//
//  Router.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "https://api.iosclass.live"
    
    case login(parameters: Parameters)
    case register(parameters: Parameters)
    case place(Parameters: Parameters)
    case travels
    case travelsId(id: String)
    case gallery(id: String)
    case places
    case upload(parameters: Parameters)
    
    var method: HTTPMethod {
        switch self {
        case .login, .register, .place, .upload:
            return .post
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/v1/auth/login"
        case .register:
            return "/v1/auth/register"
        case .place:
            return "/v1/places"
        case .travels:
            return "/v1/visits"
        case .travelsId(let id):
            return "/v1/visits/\(id)"
        case .gallery(let id):
            return "/v1/galleries/\(id)"
        case .places:
            return "/v1/places"
        case .upload:
            return "/upload"
        }
    }
    
    var parameters: Parameters? {
           switch self {
           case .login(let parameters), .register(let parameters), .place(let parameters), .upload(let parameters):
               return parameters
           default:
               return nil
           }
       }
    
    var headers: HTTPHeaders {
        
        guard let data = KeyChainHelper.shared.read(service: "access_token", account: "bilgeadam") else {
            return HTTPHeaders()
        }
        guard let token = String(data: data, encoding: .utf8) else {
            return HTTPHeaders()
        }
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
            return headers
        }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers

        switch self {
        case .login(let parameters), .register(let parameters), .place(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        default:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }

        return urlRequest
    }
}
