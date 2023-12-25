//
//  HomeDetailContracts.swift
//  MovieApp
//
//  Created by ömer atmaca on 30.09.2023.
//

import Foundation

protocol HomeDetailViewModelProtocol {
    var delegate: HomeDetailViewModelDelegate? { get set }
    var genres: [Genre]? {get set}
    var nowPlaying: NowPlaying? {get set}
    var detail: Detail? {get set}
    var movie: [Movie]? {get set}
    func load(id: String)
}

enum HomeDetailViewModelOutput: Equatable {
    case isLoading(Bool)
    case showError(String)
    case showDetail
}


protocol HomeDetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: HomeDetailViewModelOutput)
    func navigate(to route: Route, with type: TransitionType)
}
