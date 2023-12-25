//
//  SearchContracts.swift
//  MovieApp
//
//  Created by ömer atmaca on 20.12.2023.
//

import Foundation

protocol SearchViewModelProtocol {
    var delegate: SearchViewModelDelegate? { get set }
    func load()
}

enum SearchViewModelOutput: Equatable {
    case showSearch
}

protocol SearchViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: SearchViewModelOutput)
}
