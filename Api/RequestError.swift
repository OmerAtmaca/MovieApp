//
//  RequestError.swift
//  MovieApp
//
//  Created by ömer atmaca on 17.09.2023.
//

import Localize_Swift

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error".localized()
        case .unauthorized:
            return "Session expired".localized()
        default:
            return "Unknown error".localized()
        }
    }
}
