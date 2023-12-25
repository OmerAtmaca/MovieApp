//
//  HomeDetailViewModel.swift
//  MovieApp
//
//  Created by ömer atmaca on 30.09.2023.
//

import Foundation
import Alamofire


class HomeDetailViewModel: HomeDetailViewModelProtocol {
    
    var delegate: HomeDetailViewModelDelegate?
    var nowPlaying: NowPlaying?
    var genres: [Genre]?
    var detail: Detail?
    var movie: [Movie]?
    
    func load(id: String) {
        fetchData(id: id)
    }
    func fetchData(id: String) {
        self.notify(.isLoading(true))
        APIClient.request(route: .detail(id: id)) { [weak self] (result: AFResult<Detail>) in
            guard let self else { return }
            self.notify(.isLoading(false))
            switch result {
            case .success(let data):
                self.detail = data
                self.notify(.showDetail)
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
            }
        }
        
        APIClient.request(route: .movie(id: id)) { [weak self] (result: AFResult<MovieResponse<[Movie]>>) in
            guard let self else { return }
            self.notify(.isLoading(false))
            switch result {
            case .success(let data):
                    self.movie = data.results
                self.notify(.showDetail)
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
            }
        }
  
    }
    
    private func notify(_ output: HomeDetailViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
}
