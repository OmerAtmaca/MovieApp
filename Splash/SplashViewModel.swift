//
//  SplashViewModel.swift
//  ios-base
//
//  Created by Özkan Bölükbaş on 28.02.2022.
//

import Foundation



class SplashViewModel: SplashViewModelProtocol {
    
    weak var delegate: SplashViewModelDelegate?
    
    func load() {
        let gecikmeSuresi: TimeInterval = 2.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + gecikmeSuresi) { [weak self] in
            self?.notify(.showHome)
        }
        
        
    }
    
    private func notify(_ output: SplashViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
