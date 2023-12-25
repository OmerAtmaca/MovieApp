//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by ömer atmaca on 20.12.2023.
//

import Foundation

class SearchViewModel: SearchViewModelProtocol {
    
    weak var delegate: SearchViewModelDelegate?
    
    func load() {
        let gecikmeSuresi: TimeInterval = 2.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + gecikmeSuresi) { [weak self] in
            self?.notify(.showSearch)
        }
        
        
    }
    
    private func notify(_ output: SearchViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
