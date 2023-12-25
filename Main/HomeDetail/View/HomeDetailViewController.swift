//
//  HomeDetailViewController.swift
//  MovieApp
//
//  Created by ömer atmaca on 26.09.2023.
//

import UIKit

class HomeDetailViewController: BaseViewController {
    
    lazy var viewDeteilModel: HomeDetailViewModelProtocol = {
        return HomeDetailViewModel()
    }()

    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var stackButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    var genres: [Genre]?
    var dataGenre: [String] = []
    var movieId: String = ""
    
    @IBOutlet weak var playButton: UIView!
    
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailSubtitle: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action:#selector(goToPlayerViewController))
        playButton.addGestureRecognizer(tap)
        viewDeteilModel.delegate = self
        viewDeteilModel.load(id: movieId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CastCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        stackView.spacing = 10
    }
 
    
    func configure(detail: Detail?){
        guard let details = detail else{
            return
        }
        print(viewDeteilModel.detail?.productionCompanies?.count ?? 0)
        var languageList: [String] = []
        details.spokenLanguages?.forEach({ language in
            languageList.append(language.name ?? "")
        })
        detailImage.setImageWithFullUrl(with: "https://image.tmdb.org/t/p/w500/\(details.posterPath ?? "")")
        detailSubtitle.text =  "⭐️ "+"\(details.voteAverage ?? 0)"+"/10 Imdb"
        detailSubtitle.textColor = UIColor(rgb: 0x9C9C9C)
        detailTitle.text = details.title
        popularityLabel.text = String("\(details.popularity ?? 0)")
        languageLabel.text = languageList.map {($0)}.compactMap({$0}).joined(separator: ", ")
        ratingLabel.text = String("\(details.voteCount ?? 0)")
        textView.text = details.overview ?? ""
        
        playButton.layer.cornerRadius = 20
        bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 20 )
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        genres?.forEach({ genre in
            viewDeteilModel.detail?.genres?.forEach({ data in
                if data.id ==  genre.id {
                    dataGenre.append(genre.name ?? "")
                    let buttonView = UIView()
                    let button = UIButton()
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.setTitleColor(UIColor(rgb: 0x88A4E8), for: .normal)
                    button.layer.cornerRadius = 12
                    button.setTitle(genre.name?.uppercased(), for: .normal)
                    button.titleLabel?.font = .boldSystemFont(ofSize: 8)
                    button.backgroundColor = UIColor(rgb: 0xDBE3FF)
                    button.widthAnchor.constraint(equalToConstant: (genre.name?.widthOfString(usingFont: .systemFont(ofSize: 8)) ?? .zero)+30 ).isActive = true
                    button.heightAnchor.constraint(equalToConstant: 24).isActive = true
                    buttonView.addSubview(button)
                    buttonView.widthAnchor.constraint(equalTo: button.widthAnchor).isActive = true
                    stackView.addArrangedSubview(buttonView)
                }
            })
        })
    }
    
    @objc func goToPlayerViewController() {
        AppNavigator.shared.navigate(to: PlayerRoutes.player(id: viewDeteilModel.movie?[0].key ?? ""), with: .modal)
    }

}


extension HomeDetailViewController: HomeDetailViewModelDelegate {
    func handleViewModelOutput(_ output: HomeDetailViewModelOutput) {
        switch output {
        case .isLoading(let load):
            isLoading = load
        case .showError(let string):
            print(string)
        case .showDetail:
                configure(detail: viewDeteilModel.detail)
                self.collectionView.reloadData()
        }
    }
    
    func navigate(to route: Route, with type: TransitionType) {
        AppNavigator.shared.navigate(to: route, with: type)
    }
}


extension HomeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewDeteilModel.detail?.productionCompanies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CastCollectionViewCell.self, for: indexPath)
        guard let detail = viewDeteilModel.detail?.productionCompanies?[indexPath.row] else { return UICollectionViewCell() }
        cell.configureCell(detail: detail)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        goToPlayerViewController()
//
//    }
//
//    func goToPlayerViewController() {
//        AppNavigator.shared.navigate(to: PlayerRoutes.player, with: .modal)
//    }
    
 
}
