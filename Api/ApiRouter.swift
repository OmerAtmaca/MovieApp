//
//  ApiRouter.swift
//  MovieApp
//
//  Created by ömer atmaca on 17.09.2023.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case nowPlaying
    case popular
    case genres
    case detail(id: String)
    case movie(id: String)
    //case register(params: RegisterModel)
    //case withParam(id: String)
    //case withSingleBodyParam(page: Int)
    

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .nowPlaying:
            return .get
        case .popular:
            return .get
        case .genres:
            return .get
        case .detail:
            return .get
        case .movie:
                return .get
        //case .register:
          //  return .post
        //case .withParam:
          //  return .get
        //case .withSingleBodyParam:
          //  return .get
        
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .nowPlaying:
            return "3/movie/now_playing"
        case .popular:
            return "3/movie/popular"
        case .genres:
            return "3/genre/movie/list"
        case .detail(id: let id):
            return "3/movie/\(id)"
        case .movie(id: let id):
            return "3/movie/\(id)/videos"
        //case .register:
          //  return "register"
        //case .withParam(let id)
        //    return "/withParam/\(id)"
        //case .withSingleBodyParam(_):
        //    return "/withSingleBodyParam"
    
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try (Constants.Networking.baseURL).asURL()
        let ganreUrl = try (Constants.Networking.baseURL).asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        let parametersResult: Parameters = {
            switch self {
                case .nowPlaying, .popular, .genres, .detail, .movie:
                    return ["api_key":Constants.Networking.apiKey]
            //case .register(let params):
              //  return params.toDict()
            //case .withParam:
            //    return [:]
            //case .withSingleBodyParam(let page):
            //    return ["page": page]
                
            }
        }()
        
            var headers = urlRequest.allHTTPHeaderFields ?? [:]
                    headers = Constants.Networking.header.compactMapValues { $0 }
        urlRequest.allHTTPHeaderFields = headers
        if (method == .post || method == .patch) {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parametersResult)
        } else {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parametersResult)
        }
        debugPrint("------------ REQUEST -----------")
        debugPrint (urlRequest)
        debugPrint("headers: \(headers)")
        if let data = urlRequest.httpBody {
            debugPrint("parameters: \(String(decoding: data, as: UTF8.self))")
        }
        return urlRequest
    }
}

extension Encodable {
    func serialize() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }

    func prettyPrinted() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(self)
        return String(data: data, encoding: .utf8)!
    }

    func toDict() -> [String:Any] {
        do {
            return try JSONSerialization.jsonObject(with: self.serialize()!, options: [] ) as! [String : Any]
        } catch {
            debugPrint("Can't convert to dictionary")
            return [:]
        }
    }
}
