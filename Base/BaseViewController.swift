//
//  BaseViewController.swift
//  MovieApp
//
//  Created by ömer atmaca on 19.09.2023.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    var isLoading: Bool {
        get {
            return LoadingView.isLoading
        }
        set {
            newValue ? LoadingView.showLoading() : LoadingView.hideLoading()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func showError(with message: String?) {
        let alert = UIAlertController(title: Constants.Text.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showSuccess(with message: String?) {
        let alert = UIAlertController(title: Constants.Text.success, message: message, preferredStyle: .alert)
              present(alert, animated: true, completion: nil)
    }
    
    func addNavigationBackButton() {
        let backButton: UIButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: UIControl.State())
        backButton.tintColor = .black
        backButton.addTarget(self, action:#selector(onBack), for: UIControl.Event.touchUpInside)
        let leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func onBack() {
        navigationController?.popViewController(animated: true)
    }
}
