//
//  AppNavigator.swift
//  ios-base
//
//  Created by Özkan Bölükbaş on 28.02.2022.
//

import Foundation

class AppNavigator: BaseNavigator {
  static let shared = AppNavigator()

  init() {
    let initialRoute: Route = SplashRoutes.splash
    super.init(with: initialRoute)
  }

  required init(with route: Route) {
    super.init(with: route)
  }
}





