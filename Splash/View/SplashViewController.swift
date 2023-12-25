//
//  SplashViewController.swift
//  ios-base
//
//  Created by Özkan Bölükbaş on 28.02.2022.
//

import UIKit

class SplashViewController: BaseViewController {
    
    
    lazy var viewModel: SplashViewModelProtocol = {
            return SplashViewModel()
    }()

    @IBOutlet weak var titleMovieSplash: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.load()
        view.backgroundColor = .yellow
        titleMovieSplash.text = "Ömer's Movie App"

    }

}

extension SplashViewController: SplashViewModelDelegate {
    func handleViewModelOutput(_ output: SplashViewModelOutput) {
        switch output {
        case .showHome:
            navigate(to: HomeRoutes.home, with: .changeRoot)
        }
    }
    
    func navigate(to route: Route, with type: TransitionType) {
        AppNavigator.shared.navigate(to: route, with: type)
    }
    
}
