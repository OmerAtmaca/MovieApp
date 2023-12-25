//
//  UIImageViewExt.swift
//  MovieApp
//
//  Created by ömer atmaca on 9.11.2023.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImageWithFullUrl(with stringValue: String?) {
        guard let stringURLPart = stringValue else { return }
        //let url = stringURLPart.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        guard let imageURL = URL(string: "\(stringURLPart)") else { return }
        debugPrint(imageURL)
        kf.setImage(with: imageURL,  options: [.transition(.fade(0.3)), .cacheOriginalImage])
    }
    
    func maskCircle(image: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.image = image
    }
}

