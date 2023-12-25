//
//  ButtonTableViewCell.swift
//  MovieApp
//
//  Created by ömer atmaca on 21.09.2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var nowPlaying: [NowPlaying]?
    var genre: [Genre]?
    
    @IBOutlet weak var movieCollection: UICollectionView!
    @IBOutlet weak var movieTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        movieTitle.text = "Now Playings"
        movieCollection.delegate = self
        movieCollection.dataSource = self
        movieCollection.register(cellType: MovieCollectionViewCell.self)
        movieCollection.showsHorizontalScrollIndicator = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlaying?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MovieCollectionViewCell.self, for: indexPath)
        guard let nowPlaying = nowPlaying?[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(nowPlaying: nowPlaying)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        goToHomeDetailViewController(dataId: String(self.nowPlaying?[indexPath.row].id ?? 0), genre: self.genre)
       
    }
    
    func goToHomeDetailViewController(dataId: String, genre: [Genre]?) {
        AppNavigator.shared.navigate(to: HomeDetailRoutes.homeDetail(genre: genre ?? [], movieId: dataId), with: .push)
    }

}

