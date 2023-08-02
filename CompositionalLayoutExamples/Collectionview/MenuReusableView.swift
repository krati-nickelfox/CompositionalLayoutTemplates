//
//  MenuReusableView.swift
//  CompositionalLayoutExamples
//
//  Created by Krati Mittal on 02/08/23.
//

import UIKit

protocol MenuReusableViewDelegate {
    func menuTapped()
}

class MenuReusableView: UICollectionReusableView {
    static let reuseIdentifier = "MenuReusableView-identifier"
    
    let menuButton = UIButton()
    var delegate: MenuReusableViewDelegate?
    
    // Default initialiser for cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    //
    required init(coder: NSCoder) {
        fatalError("not implemented")
    }
    
}

extension MenuReusableView {
    func configure() {
        self.menuButton.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
        self.menuButton.translatesAutoresizingMaskIntoConstraints = false
        self.menuButton.setTitle("", for: .normal)
        self.menuButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        self.menuButton.tintColor = .black
        self.addSubview(self.menuButton)
        
        let inset = CGFloat(5)
        NSLayoutConstraint.activate([
            menuButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            menuButton.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            menuButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset),
            menuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
        ])
    }
    
    @objc func didTapMenu() {
        self.delegate?.menuTapped()
    }
    
}
