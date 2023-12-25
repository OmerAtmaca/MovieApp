//
//  MenuViewModel.swift
//  MovieApp
//
//  Created by ömer atmaca on 11.12.2023.
//

import Foundation

class MenuViewModel: MenuViewModelProtocol {
    
    weak var delegate: MenuViewModelDelegate?
    
    func load() {
        let gecikmeSuresi: TimeInterval = 2.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + gecikmeSuresi) { [weak self] in
            self?.notify(.showMenu)
        }
        
        
    }
    
    private func notify(_ output: MenuViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
