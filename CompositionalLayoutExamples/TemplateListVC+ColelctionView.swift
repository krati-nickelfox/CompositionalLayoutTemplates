//
//  TemplateListVC+ColelctionView.swift
//  CompositionalLayoutExamples
//
//  Created by Krati Mittal on 02/08/23.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension TemplateListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reuseIdentifier, for: indexPath) as? TextCell else {
                return UICollectionViewCell()
            }
            
            cell.label.text = self.categories[indexPath.item].uppercased()
            cell.layer.cornerRadius = 18.0
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.black.cgColor
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContainerCell.reuseIdentifier, for: indexPath) as? ContainerCell else {
                return UICollectionViewCell()
            }
            print("self.categories for item \(indexPath.item)\n \(self.categoryDetails[indexPath.item])")
            cell.categories = self.categoryDetails[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: MenuReusableView.reuseIdentifier,
                                                                                   for: indexPath) as? MenuReusableView else {
                return UICollectionReusableView()
            }
            headerView.delegate = self
            return headerView
        }
        return UICollectionReusableView()
    }
    
}


// MARK: - UICollectionViewDelegate
extension TemplateListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            (0..<self.categories.count).forEach { index in
                if index != indexPath.item {
                    let cellIndex = IndexPath(item: index, section: 0)
                    self.collectionView.cellForItem(at: cellIndex)?.isSelected = false
                }
            }
            collectionView.cellForItem(at: indexPath)?.isSelected = true
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

            let detailIndexPath = IndexPath(item: indexPath.item, section: 1)
            collectionView.scrollToItem(at: detailIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //            let categoryIndexPath = IndexPath(item: indexPath.item, section: 0)
        //            if !(collectionView.cellForItem(at: categoryIndexPath)?.isSelected ?? false) {
        //                (0..<self.categories.count).forEach { index in
        //                    let cellIndex = IndexPath(item: index, section: 0)
        //                    collectionView.cellForItem(at: cellIndex)?.isSelected = false
        //                }
        
        //                let firstSectionIndexPath = IndexPath(item: indexPath.item + 1, section: 0)
        //                collectionView.scrollToItem(at: firstSectionIndexPath, at: .centeredHorizontally, animated: true)
        //                collectionView.cellForItem(at: firstSectionIndexPath)?.isSelected = true
        //            }
        
    }
    
}

