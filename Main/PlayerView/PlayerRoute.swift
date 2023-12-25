//
//  PlayerRoute.swift
//  MovieApp
//
//  Created by ömer atmaca on 1.10.2023.
//

import Foundation
import UIKit

enum PlayerRoutes: Route {
    case player(id: String)

  var screen: UIViewController {
    switch self {
    case .player(let id):
        let vc = PlayerViewController(nibName: PlayerViewController.className, bundle: nil)
            vc.videoId = id
            return vc
    }
  }
}
