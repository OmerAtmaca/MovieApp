//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by ömer atmaca on 23.09.2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
 
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var moviePoint: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
  
    override func prepareForReuse() {
        super.prepareForReuse()
      
        movieImage.image = nil
        movieTitle.text = ""
        moviePoint.text = ""
        
    }

    func configure(nowPlaying: NowPlaying) {
        movieImage.setImageWithFullUrl(with:"https://image.tmdb.org/t/p/w500/"+nowPlaying.posterPath)
        movieImage.layer.cornerRadius = 10
        
        movieTitle.text = nowPlaying.title
        moviePoint.text = "⭐️ "+String(nowPlaying.voteAverage)+"/10 Imdb"
        moviePoint.textColor = UIColor(.gray)
    }

}




