//
//  ListCell.swift
//  CompositionalLayoutExamples
//
//  Created by Krati Mittal on 02/08/23.
//

import UIKit

class ListCell: UICollectionViewCell {
    static let reuseIdentifier = "list-cell-reuse-identifier"
    
    let label = UILabel()
    let accessoryImageView = UIImageView()
    let seperatorView = UIView()
    
    /// Initialisation
    
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

extension ListCell {
    func configure() {
        //
        self.label.translatesAutoresizingMaskIntoConstraints = false
        //
        self.label.adjustsFontForContentSizeCategory = false
        self.label.font = UIFont.preferredFont(forTextStyle: .body)
        self.contentView.addSubview(self.label)
        
        self.seperatorView.translatesAutoresizingMaskIntoConstraints = false
        self.seperatorView.backgroundColor = .lightGray
        self.contentView.addSubview(self.seperatorView)
        
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .lightGray.withAlphaComponent(0.3)
        
        self.accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.accessoryImageView)

        let rtl = effectiveUserInterfaceLayoutDirection == .rightToLeft
        let chevronImageName = rtl ? "chevron.left" : "chevron.right" // SF Symbol
        let chevronImage = UIImage(systemName: chevronImageName)
        self.accessoryImageView.image = chevronImage
        self.accessoryImageView.tintColor = .lightGray.withAlphaComponent(0.7)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            label.trailingAnchor.constraint(equalTo: accessoryImageView.leadingAnchor, constant: -inset),
            
            accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 13),
            accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            seperatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            seperatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            seperatorView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -inset),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.5),
        ])
    }
    
}
