//
//  SearchRoutes.swift
//  MovieApp
//
//  Created by ömer atmaca on 20.12.2023.
//

import Foundation
import UIKit

enum SearchRoutes: Route {
  case search
    
  var screen: UIViewController {
    switch self {
    case .search:
        return SearchViewController(nibName: SearchViewController.className, bundle: nil)
    }
  }
}



