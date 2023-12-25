//
//  CastCollectionViewCell.swift
//  MovieApp
//
//  Created by ömer atmaca on 30.09.2023.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleActor: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
      
        imageView.image = nil
        titleActor.text = ""
    }

    func configureCell(detail: ProductionCompany) {
        imageView.setImageWithFullUrl(with:"https://image.tmdb.org/t/p/w500/"+(detail.logoPath ?? ""))
        imageView.layer.cornerRadius = 10
        titleActor.text = detail.name
    }

}
