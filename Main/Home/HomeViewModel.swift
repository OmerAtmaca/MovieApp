//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by ömer atmaca on 19.09.2023.
//

import Foundation
import Alamofire


class HomeViewModel: HomeViewModelProtocol {
    func load() {
        fetchData()
    }
    
    var delegate: HomeViewModelDelegate?
    var nowPlaying: [NowPlaying]?
    var popularList: [Popular]?
    var popular: [Popular]?
    var genres: [Genre]?
    var detail: Detail?
    var menuState: MenuState = .closed
    
    func fetchData() {
        self.notify(.isLoading(true))
        APIClient.request(route: .nowPlaying) { [weak self] (result: AFResult<BaseResponse<[NowPlaying]>>) in
            guard let self else { return }
            switch result {
            case .success(let data):
                guard let nowPlaying = data.results else {
                    return
                }
                self.nowPlaying = nowPlaying
                self.notify(.showNowPlaying)
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
            }
        }
        
        APIClient.request(route: .popular) { [weak self] (result: AFResult<BaseResponse<[Popular]>>) in
            guard let self else { return }
            switch result {
            case .success(let data):
                guard let popular = data.results else {
                    return
                }
                self.popular = popular
                    self.popularList = popular
                self.notify(.showNowPlaying)
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
            }
        }
        
        APIClient.request(route: .genres) { [weak self] (result: AFResult<GenreResponse<[Genre]>>) in
            guard let self else { return }
            self.notify(.isLoading(false))
            switch result {
            case .success(let data):
                    guard let genres = data.genres else {
                    return
                }
                self.genres = genres
                self.notify(.showNowPlaying)
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
            }
        }
    }
    
    private func notify(_ output: HomeViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
