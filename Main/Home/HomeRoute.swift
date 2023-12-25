//
//  HomeRoute.swift
//  MovieApp
//
//  Created by ömer atmaca on 20.09.2023.
//

import Foundation
import UIKit

enum HomeRoutes: Route {
  case home

  var screen: UIViewController {
    switch self {
    case .home:
        return HomeViewController(nibName: HomeViewController.className, bundle: nil)
    }
  }
}
