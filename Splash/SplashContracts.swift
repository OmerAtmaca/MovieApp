//
//  SplashContracts.swift
//  ios-base
//
//  Created by Özkan Bölükbaş on 28.02.2022.
//

import Foundation

protocol SplashViewModelProtocol {
    var delegate: SplashViewModelDelegate? { get set }
    func load()
}

enum SplashViewModelOutput: Equatable {
    case showHome
}

protocol SplashViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: SplashViewModelOutput)
    func navigate(to route: Route, with type: TransitionType)
}
