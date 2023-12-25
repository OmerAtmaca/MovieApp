//
//  UIRefreshControlExt.swift
//  ios-base
//
//  Created by Özkan Bölükbaş on 7.03.2022.
//

import Foundation
import UIKit

extension UIRefreshControl {
    func programaticallyBeginRefreshing(in tableView: UITableView?) {
        beginRefreshing()
        let offsetPoint = CGPoint.init(x: 0, y: -frame.size.height)
        tableView?.setContentOffset(offsetPoint, animated: true)
    }
}
