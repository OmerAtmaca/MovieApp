//
//  MostPopularTableViewCell.swift
//  MovieApp
//
//  Created by ömer atmaca on 25.09.2023.
//

import UIKit

class MostPopularTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var labelPopular: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var genres: [Genre]?
    var dataGenre: [String] = []
    var popular: Popular?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.spacing = 10
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
        subtitle.text = ""
        title.text = ""
        timeLabel.text = ""
        labelPopular.text = "Popular"
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    
    func configure(popular: Popular) {
        posterImage.setImageWithFullUrl(with:"https://image.tmdb.org/t/p/w500/"+popular.posterPath)
        posterImage.layer.cornerRadius = 10
        title.text = popular.title
        subtitle.text = "⭐️ "+String(popular.voteAverage)+"/10 Imdb"
        subtitle.textColor = UIColor(.gray)
        timeLabel.text = popular.releaseDate
    
        genres?.forEach({ genre in
            print("\(genre.id ?? 0)")
            popular.genreIDS.forEach({ data in
                if data ==  genre.id {
                    print(data)
                    dataGenre.append(genre.name ?? "")
                    let buttonView = UIView()
                    let button = UIButton()
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.setTitleColor(.black, for: .normal)
                    button.layer.cornerRadius = 12
                    button.setTitle(genre.name?.uppercased(), for: .normal)
                    button.titleLabel?.font = .boldSystemFont(ofSize: 8)
                    button.backgroundColor = UIColor(rgb: 0xDBE3FF)
                    button.widthAnchor.constraint(equalToConstant: (genre.name?.widthOfString(usingFont: .systemFont(ofSize: 8)) ?? .zero) + 30).isActive = true
                    button.heightAnchor.constraint(equalToConstant: 24).isActive = true
                    buttonView.addSubview(button)
                    buttonView.widthAnchor.constraint(equalTo: button.widthAnchor).isActive = true
                    stackView.addArrangedSubview(buttonView)
                }
            })
        })
      
    }
}

