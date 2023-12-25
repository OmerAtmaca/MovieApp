//
//  GenreResponse.swift
//  MovieApp
//
//  Created by ömer atmaca on 29.09.2023.
//

import Foundation

struct GenreResponse<T: Codable>: Codable {
    let genres: [Genre]?
}

