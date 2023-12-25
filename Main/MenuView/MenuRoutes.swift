//
//  MenuRoutes.swift
//  MovieApp
//
//  Created by ömer atmaca on 11.12.2023.
//

import Foundation
import UIKit

enum MenuRoutes: Route {
  case menu
    
  var screen: UIViewController {
    switch self {
    case .menu:
        return MenuViewController(nibName: MenuViewController.className, bundle: nil)
    }
  }
}



