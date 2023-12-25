//
//  BaseResponse.swift
//  MovieApp
//
//  Created by ömer atmaca on 19.09.2023.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let dates:Dates?
    var page: Int? = 1
    let results : T?
}

struct Info: Codable {
    let count, pages: Int?
    let next: String?
}

struct Dates: Codable {
    let maximum, minimum: String
}
