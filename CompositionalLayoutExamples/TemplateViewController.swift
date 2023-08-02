//
//  TemplateViewController.swift
//  CompositionalLayoutExamples
//
//  Created by Krati Mittal on 30/07/23.
//

import UIKit

protocol TemplateViewControllerDelegate: AnyObject {
    func didSelectMenuItemAt(index: Int)
}

class TemplateViewController: UIViewController {
    
    var collectionView: UICollectionView! = nil
    var categories = [String]()
    weak var delegate: TemplateViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureHeirarchy()
    }
    
    private func configureHeirarchy() {
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.createLayout())
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        self.collectionView.register(TemplateMenuReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TemplateMenuReusableView.reuseIdentifier)
        
        self.view.addSubview(self.collectionView)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let section = CollectionTemplate.createMenuLayout()
        section.contentInsets = .init(top: 40, leading: 20, bottom: 20, trailing: 20)
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .absolute(44)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}

// MARK: - UICollectionViewDataSource
extension TemplateViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reuseIdentifier, for: indexPath) as? TextCell else {
            return UICollectionViewCell()
        }
        
        cell.label.text = self.categories[indexPath.item]
        cell.layer.cornerRadius = 18.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: TemplateMenuReusableView.reuseIdentifier,
                                                                               for: indexPath) as? TemplateMenuReusableView else {
            return UICollectionReusableView()
        }
        headerView.delegate = self
        return headerView
    }
    
}

// MARK: - UICollectionViewDelegate
extension TemplateViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.delegate?.didSelectMenuItemAt(index: indexPath.item)
        }
    }
    
}

// MARK: - TemplateMenuReusableViewDelegate
extension TemplateViewController: TemplateMenuReusableViewDelegate {
    
    func crossButtonTapped() {
        self.dismiss(animated: true)
    }
    
}
