//
//  HomeContracts.swift
//  MovieApp
//
//  Created by ömer atmaca on 19.09.2023.
//

import Foundation

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    var nowPlaying: [NowPlaying]? { get set }
    var popular: [Popular]? {get set}
    var popularList: [Popular]? {get set}
    var genres: [Genre]? {get set}
    var menuState: MenuState {get set}
    func load()
}

enum MenuState: Equatable {
    case opened
    case closed
}

enum HomeViewModelOutput: Equatable {
    case isLoading(Bool)
    case showError(String)
    case showNowPlaying
}


protocol HomeViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: HomeViewModelOutput)
    func navigate(to route: Route, with type: TransitionType)
}

