//
//  LoadingView.swift
//  MovieApp
//
//  Created by ömer atmaca on 20.09.2023.
//

import UIKit

class LoadingView: BaseUIView {
    
    
    @IBOutlet weak var proggress: UIActivityIndicatorView!
    
    static private var tagNumber = 100123
    static var isLoading: Bool {
        guard let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first,
       keyWindow.viewWithTag(LoadingView.tagNumber) != nil else {
            return false
        }
        return true
    }
    
    override func postInit() {
        proggress.startAnimating()
    }

    
    static func showLoading() {
        guard let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first,
              keyWindow.viewWithTag(LoadingView.tagNumber) == nil else {
            return
        }
        let loadingView = LoadingView(frame: keyWindow.frame)
        loadingView.tag = LoadingView.tagNumber
        keyWindow.addSubview(loadingView)
        keyWindow.bringSubviewToFront(loadingView)
        DispatchQueue.main.async {
            loadingView.proggress.startAnimating()
        }
    }
    
    static func hideLoading() {
        guard let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first else {
            return
        }
        guard let loadingView = keyWindow.viewWithTag(LoadingView.tagNumber) as? LoadingView else {
            return
        }
        DispatchQueue.main.async {
            loadingView.proggress.stopAnimating()
        }
        loadingView.removeFromSuperview()
    }
}



