//
//  MenuTableViewCell.swift
//  MovieApp
//
//  Created by ömer atmaca on 15.12.2023.
//

import Foundation
import UIKit

class MenuTableViewCell: UITableViewCell {
    
    var titleName: String?
    
    @IBOutlet weak var title: UILabel!
    
    override func prepareForReuse() {
        title.text = ""
    }
    
    func configure(list: String) {
        title.text = list
        title.textColor = UIColor(.red)
    }
    
}
