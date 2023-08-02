//
//  TemplateListViewController.swift
//  CompositionalLayoutExamples
//
//  Created by Krati Mittal on 30/07/23.
//

import UIKit

class TemplateListViewController: UIViewController {
    
//    enum Section {
//        case main
//    }

//    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    let categories = ["Popular", "Love", "Pro", "Effect", "Aesthetic", "Girlish", "Vlog", "Paint", "Daily", "Neon", "Celebrate", "Mood", "Text", "Travel", "Pet", "Graphic", "Holiday", "Sports", "Family", "Face Play"]
    var categoryDetails = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryDetails = self.categories.map({ Array(repeating: $0, count: (2...10).randomElement() ?? 1)})
        print("complete self.categoryDetails\n\(self.categoryDetails)")
            
        self.configureHeirarchy()
//        self.configureDataSource()
    }
    
    private func configureHeirarchy() {
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.createLayout())
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        self.collectionView.register(ContainerCell.self, forCellWithReuseIdentifier: ContainerCell.reuseIdentifier)
        self.collectionView.register(MenuReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MenuReusableView.reuseIdentifier)
        
        self.view.addSubview(self.collectionView)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                let section = CollectionTemplate.createContinusHorizontalLayout()
                section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(widthDimension: .absolute(44),
                                      heightDimension: .absolute(44)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading
                )]

                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                       heightDimension: .fractionalHeight(1.0))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 20
                section.contentInsets = .init(top: 30, leading: 20, bottom: 0, trailing: 20)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
                
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                      heightDimension: .fractionalHeight(0.2))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                item.contentInsets = .init(top: 15, leading: 0, bottom: 0, trailing: 0)
//
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                       heightDimension: .fractionalHeight(1.0))
//                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
//                group.interItemSpacing = .flexible(8)
//
//                let mainGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
//                                                           heightDimension: .fractionalHeight(0.8))
//                let mainGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mainGroupSize, subitem: group, count: 5)
//
//                let section = NSCollectionLayoutSection(group: mainGroup)
//                section.interGroupSpacing = 20
//                section.contentInsets = .init(top: 30, leading: 20, bottom: 0, trailing: 20)
//                section.orthogonalScrollingBehavior = .continuous
//
//                return section
            }
        }
        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
    }


//    private func configureDataSource() {
//
//        // Create Diffiable data source and connect to collection view
//        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//
//            // A constructor that passes the collection view as input and returns a cell as output
//            guard let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: TextCell.reuseIdentifier,
//                for: indexPath) as? TextCell else {
//                fatalError("Cannot create new cell")
//            }
//
//            cell.label.text = self.categories[itemIdentifier]
//            cell.layer.cornerRadius = 5.0
//            cell.layer.borderWidth = 1.0
//            cell.layer.borderColor = UIColor.black.cgColor
//
//            return cell
//        })
//
//        /// Warning: forgetting to set snapshot, will result in empty collection view
//        // Initial data
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(Array(0..<self.categories.count))
//        dataSource.apply(snapshot, animatingDifferences: false)
//    }

}

// MARK: - MenuReusableViewDelegate
extension TemplateListViewController: MenuReusableViewDelegate {
    func menuTapped() {
        let sb = UIStoryboard.init(name: "Main",
                                   bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "TemplateViewController") as? TemplateViewController else { return }
        vc.categories = self.categories
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
}

// MARK: - TemplateViewControllerDelegate
extension TemplateListViewController: TemplateViewControllerDelegate {
    func didSelectMenuItemAt(index: Int) {
        (0..<self.categories.count).forEach { index in
            let cellIndex = IndexPath(item: index, section: 0)
            self.collectionView.cellForItem(at: cellIndex)?.isSelected = false
        }
        let firstSectionIndexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: firstSectionIndexPath, at: .centeredHorizontally, animated: true)
        
        let secondSectionIndexPath = IndexPath(item: index, section: 1)
        collectionView.scrollToItem(at: secondSectionIndexPath, at: .centeredHorizontally, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.collectionView.cellForItem(at: firstSectionIndexPath)?.isSelected = true
        }
    }
    
}
