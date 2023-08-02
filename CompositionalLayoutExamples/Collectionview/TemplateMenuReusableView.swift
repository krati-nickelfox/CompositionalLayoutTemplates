//
//  TemplateMenuReusableView.swift
//  CompositionalLayoutExamples
//
//  Created by Krati Mittal on 02/08/23.
//

import UIKit

protocol TemplateMenuReusableViewDelegate {
    func crossButtonTapped()
}

class TemplateMenuReusableView: UICollectionReusableView {
    static let reuseIdentifier = "TemplateMenuReusableView-identifier"
    
    let crossButton = UIButton()
    let label = UILabel()

    var delegate: TemplateMenuReusableViewDelegate?
    
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

extension TemplateMenuReusableView {
    func configure() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.text = "Label quick selection"
        self.label.font = .boldSystemFont(ofSize: 16)
        self.addSubview(self.label)
        
        self.crossButton.addTarget(self, action: #selector(didTapCrossButton), for: .touchUpInside)
        self.crossButton.translatesAutoresizingMaskIntoConstraints = false
        self.crossButton.setTitle("", for: .normal)
        self.crossButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        self.crossButton.tintColor = .black
        self.addSubview(self.crossButton)
        
        let inset = CGFloat(15)
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            self.label.trailingAnchor.constraint(equalTo: self.crossButton.leadingAnchor, constant: -inset),
            self.label.heightAnchor.constraint(equalToConstant: 44),

            self.crossButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            self.crossButton.centerYAnchor.constraint(equalTo: self.label.centerYAnchor),
            self.crossButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func didTapCrossButton() {
        self.delegate?.crossButtonTapped()
    }
    
}
