//
//  Movie.swift
//  MovieApp
//
//  Created by ömer atmaca on 1.10.2023.
//

import Foundation

// MARK: - Movie
struct MovieResponse<T: Codable>: Codable {
    let id: Int?
    let results: T?
}

// MARK: - Result
struct Movie: Codable {
    let iso639_1, iso3166_1, name, key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1
        case iso3166_1
        case name, key, site, size, type, official
        case publishedAt
        case id
    }
}
