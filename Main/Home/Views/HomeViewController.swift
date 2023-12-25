//
//  HomeViewController.swift
//  MovieApp
//
//  Created by ömer atmaca on 19.09.2023.
//


import UIKit
import SideMenu

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel: HomeViewModelProtocol = {
        return HomeViewModel()
    }()
    private var sideMenuViewController = MenuViewController()
       private var sideMenuRevealWidth: CGFloat = 260
       private let paddingForRotation: CGFloat = 150
       private var isExpanded: Bool = false
       
       private var sideMenuTrailingConstraint: NSLayoutConstraint!
       
       private var revealSideMenuOnTop: Bool = true
       
       private var sideMenuShadowView: UIView!
       
       private var draggingIsEnabled: Bool = false
       private var panBaseLocation: CGFloat = 0.0
       private var tapGestureRecognizer: UITapGestureRecognizer!
       
       @IBAction open func revealSideMenu() {
           self.sideMenuState(expanded: self.isExpanded ? false : true)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.register(cellType: MovieTableViewCell.self)
        tableView.register(cellType: MostPopularTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(revealSideMenu))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "search"), style: .done, target: self, action: #selector(clickSearchButton))
        
                    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
                    panGestureRecognizer.delegate = self
                    view.addGestureRecognizer(panGestureRecognizer)
                
                self.sideMenuShadowView = UIView(frame: self.view.bounds)
                self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.sideMenuShadowView.backgroundColor = .black
                self.sideMenuShadowView.alpha = 0.0
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
                tapGestureRecognizer.numberOfTapsRequired = 1
                tapGestureRecognizer.delegate = self
                self.sideMenuViewController.defaultHighlightedCell = 0
        self.sideMenuViewController.viewModel.delegate = self
        view.insertSubview(self.sideMenuViewController.view, at: revealSideMenuOnTop ? 2 : 0)
                addChild(self.sideMenuViewController)
        if self.revealSideMenuOnTop {
            view.insertSubview(sideMenuShadowView, belowSubview: self.sideMenuViewController.view)
        }
                self.sideMenuViewController.didMove(toParent: self)
                
                self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
                
                if self.revealSideMenuOnTop {
                    self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
                    self.sideMenuTrailingConstraint.isActive = true
                }
                NSLayoutConstraint.activate([
                    self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
                    self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
                ])
                
//                showViewController(viewController: UINavigationController())
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.load()
    }
    
    @objc func clickSearchButton(){
        AppNavigator.shared.navigate(to: SearchRoutes.search, with: .modal)
    }


}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return viewModel.popular?.count ?? 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(with: MovieTableViewCell.self, for: indexPath)
            guard let nowPlaying = viewModel.nowPlaying else { return UITableViewCell() }
            cell.nowPlaying = nowPlaying
            cell.genre = viewModel.genres
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(with: MostPopularTableViewCell.self, for: indexPath)
            guard let popular = viewModel.popular?[indexPath.row] else { return UITableViewCell() }
            cell.popular = viewModel.popular?[indexPath.row]
            cell.genres = viewModel.genres
            cell.configure(popular: popular)
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                cell.labelPopular.text = "Popular"
            }else {
                cell.labelPopular.text = ""
            }
            return cell
        }
        return UITableViewCell()
    }
}
    
    extension HomeViewController: HomeViewModelDelegate {
        func handleViewModelOutput(_ output: HomeViewModelOutput) {
            switch output {
                case .isLoading(let load):
                    isLoading = load
                case .showError(let string):
                    print(string)
                case .showNowPlaying:
                    self.tableView.reloadData()
            }
        }
        
        func navigate(to route: Route, with type: TransitionType) {
            AppNavigator.shared.navigate(to: route, with: type)
        }
    }

extension HomeViewController: MenuViewModelDelegate {
    func handleViewModelOutput(_ output: MenuViewModelOutput) {
    }
    
    func selectedCell(_ row: Int) {
        switch row {
            case 0 : print("deneme")
//            self.showViewController(viewController: HomeViewController())
            
        default:
            break
        }
        
        DispatchQueue.main.async { self.sideMenuState(expanded: false) }
    }
    
//    func showViewController<T: UIViewController>(viewController: T) -> () {
//        for subview in view.subviews {
//            if subview.tag == 99 {
//                subview.removeFromSuperview()
//            }
//        }
//        let vc = viewController
//        vc.view.tag = 99
//        view.insertSubview(vc.view, at: self.revealSideMenuOnTop ? 0 : 1)
//        addChild(vc)
//        if !self.revealSideMenuOnTop {
//            if isExpanded {
//                vc.view.frame.origin.x = self.sideMenuRevealWidth
//            }
//            if self.sideMenuShadowView != nil {
//                vc.view.addSubview(self.sideMenuShadowView)
//            }
//        }
//        vc.didMove(toParent: self)
//    }
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            view.addGestureRecognizer(tapGestureRecognizer)
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }

            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
        }
        else {
            view.removeGestureRecognizer(tapGestureRecognizer)
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }

            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
}

extension UIViewController {
    
    func revealViewController() -> HomeViewController? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is HomeViewController {
            return viewController! as? HomeViewController
        }
        while (!(viewController is HomeViewController) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is HomeViewController {
            return viewController as? HomeViewController
        }
        return nil
    }
    
    
}

extension HomeViewController {
    
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x

        switch sender.state {
        case .began:

            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }

            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }

            if self.draggingIsEnabled {
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }

                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }

        case .changed:

            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth

                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha

                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth

                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha

                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}
