//
//  TextCell.swift
//  CompositionalLayoutExamples
//
//  Created by Krati Mittal on 02/08/23.
//

import UIKit

class TextCell: UICollectionViewCell {
    static let reuseIdentifier = "text-cell-reuse-identifier"
    
    let label = UILabel()
    
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

extension TextCell {
    func configure() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.adjustsFontForContentSizeCategory = false
        self.label.numberOfLines = 0
        self.label.font = .boldSystemFont(ofSize: 14)
        self.label.textAlignment = .center
        self.contentView.addSubview(self.label)
        
        selectedBackgroundView = UIView()
        selectedBackgroundView?.layer.cornerRadius = 18.0
        selectedBackgroundView?.backgroundColor = .lightGray.withAlphaComponent(0.3)
        
        let inset = CGFloat(5)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
    
}


