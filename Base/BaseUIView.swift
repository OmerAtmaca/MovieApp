//
//  AppDelegate.swift
//  MovieApp
//
//  Created by ömer atmaca on 17.09.2023.
//


import Foundation
import UIKit

protocol BaseUIViewProtocol: AnyObject {
    var contentView: UIView! { get set }
    var nibName: String { get }
    
    func commonInit()
    func postInit()
}

extension BaseUIViewProtocol where Self: UIView {
    func commonInit() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        postInit()
    }
}


@IBDesignable
class BaseUIView: UIView, BaseUIViewProtocol {
    
    @IBOutlet var contentView: UIView!
    var nibName: String {
        print(Self.self)
        let name = String(describing: Self.self)
        return name.components(separatedBy: ".").last ?? name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func postInit() { }
}
