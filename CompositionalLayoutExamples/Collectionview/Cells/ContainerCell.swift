//
//  ContainerCell.swift
//  CompositionalLayoutExamples
//
//  Created by Krati Mittal on 02/08/23.
//

import UIKit

class ContainerCell: UICollectionViewCell {
    
    var categories: [String] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    static let reuseIdentifier = "container-cell-reuse-identifier"
    
    var collectionView: UICollectionView!
    
    // Default initialiser for cell
    override init(frame: CGRect) {
        self.categories = [String]()
        super.init(frame: frame)
        self.configure()
    }
    
    //
    required init(coder: NSCoder) {
        fatalError("not implemented")
    }
    
}

extension ContainerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reuseIdentifier, for: indexPath) as? TextCell else {
            return UICollectionViewCell()
        }
        
        cell.label.text = self.categories[indexPath.item]
        //cell.layer.cornerRadius = 5.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.black.cgColor

        return cell
    }
    
    private func configure() {
        self.collectionView = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: self.createLayout())

        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.dataSource = self
        self.collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        self.contentView.addSubview(self.collectionView)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let section = CollectionTemplate.createSingleColumnLayout()
        return UICollectionViewCompositionalLayout(section: section)
    }

}
