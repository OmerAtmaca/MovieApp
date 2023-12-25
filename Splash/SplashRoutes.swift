//
//  SplashRoutes.swift
//  ios-base
//
//  Created by Özkan Bölükbaş on 28.02.2022.
//

import Foundation
import UIKit

enum SplashRoutes: Route {
  case splash
    
  var screen: UIViewController {
    switch self {
    case .splash:
        return SplashViewController(nibName: SplashViewController.className, bundle: nil)
    }
  }
}



