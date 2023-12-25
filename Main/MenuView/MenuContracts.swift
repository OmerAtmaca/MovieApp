//
//  MenuContracts.swift
//  MovieApp
//
//  Created by ömer atmaca on 11.12.2023.
//

import Foundation

protocol MenuViewModelProtocol {
    var delegate: MenuViewModelDelegate? { get set }
    func load()
}

enum MenuViewModelOutput: Equatable {
    case showMenu
}

protocol MenuViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: MenuViewModelOutput)
    func selectedCell(_ row: Int)
}
