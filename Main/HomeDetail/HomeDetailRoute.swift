//
//  HomeDetailRoute.swift
//  MovieApp
//
//  Created by ömer atmaca on 26.09.2023.
//

import Foundation
import UIKit

enum HomeDetailRoutes: Route {
    case homeDetail(genre: [Genre], movieId: String)

  var screen: UIViewController {
    switch self {
    case .homeDetail(let genre, let movieId):
            let vc = HomeDetailViewController(nibName: HomeDetailViewController.className, bundle: nil)
            vc.genres = genre
            vc.movieId = movieId
            return vc
    }
  }
}
