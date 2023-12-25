//
//  FilterViewController.swift
//  MovieApp
//
//  Created by ömer atmaca on 2.12.2023.
//

import UIKit

class MenuViewController: BaseViewController {
    
    lazy var viewModel: MenuViewModelProtocol = {
        return MenuViewModel()
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var defaultHighlightedCell: Int = 0
    
    let menuList = ["Animation", "Comedy", "Family", "Fantasy", "Music", "Reality", "Dram", "Love", "Discovery"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: MenuTableViewCell.self)
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(with: MenuTableViewCell.self, for: indexPath)
            let listCell = menuList[indexPath.row]
            cell.configure(list: listCell)
            return cell
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.viewModel.delegate?.selectedCell(indexPath.row)
    }
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return menuList.count
    }
    
}
    
    
    
    

    

    

