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
    case place(parameters: Parameters)
    case travels
    case travelsId(id: String)
    case gallery(id: String)
    case places
    case upload(image: [Data])
    case postGallery(parameters: Parameters)
    
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
        case .postGallery:
            return "/v1/galleries"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let parameters), .register(let parameters), .place(let parameters), .postGallery(let parameters):
            return parameters
        default:
            return nil
        }
    }
    
    var multipartFormData:MultipartFormData {
        let formData = MultipartFormData()
        switch self {
        case .upload(let imageData):
            imageData.forEach { image in
                formData.append(image, withName: "image.jpg", mimeType: "image/jpeg" )
            }
            return formData
        default:
            break
        }
        return formData
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
        case .login(let parameters), .register(let parameters), .place(let parameters), .postGallery(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .upload:
            let uploadURLRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            return uploadURLRequest
        default:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }
        
        return urlRequest
    }
    
    
}
