//
//  ExtensionCollectionView.swift
//  MyGarage
//
//  Created by user on 07.01.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
import UIKit

extension PartsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch self.sectionsArray[indexPath.section].type {
            
        case "CategoriParts":
            guard let id = self.dataSource?.itemIdentifier(for: indexPath) else { return }
            guard var snaphost = self.dataSource?.snapshot() else { return }
            
            snaphost.deleteItems(self.itemsArray)
            
            guard let itemIndex = snaphost.indexOfItem(id) else { return }
            self.itemsArray = HelperMethods.shared.createMPart(array: partsNames[itemIndex])
            snaphost.appendItems(self.itemsArray, toSection: self.sectionsArray.last)
            
            dataSource?.apply(snaphost, animatingDifferences: true)
            
            collectionView.deselectItem(at: indexPath, animated: true)
        default:
            print("default")
        }
    }
}

extension PartsViewController {
    
    //MARK: Composit Layout
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        collectionView.register(FirstCell.self, forCellWithReuseIdentifier: FirstCell.reuseId)
        collectionView.register(SecondCell.self, forCellWithReuseIdentifier: SecondCell.reuseId)
        
        createDataSource()
        reloadData()
        
        collectionView.delegate = self
    }
    
    //    private func configure<T: SelfConfiguringCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath) -> T {
    //        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("Error \(cellType)")}
    //        return cell
    //    }
    
    // MARK: - Manage the data in UICV
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MSection, MPart>(collectionView: collectionView
            , cellProvider: { (collectionView, indexPath, part) -> UICollectionViewCell? in
                switch self.sectionsArray[indexPath.section].type {
                    
                case "CategoriParts":
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstCell.reuseId, for: indexPath) as? FirstCell
                    cell?.configure(with: part.partName)
                    return cell
                default:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCell.reuseId, for: indexPath) as? SecondCell
                    cell?.configure(with: part.partName)
                    cell?.cartButton.addTarget(self, action: #selector(PartsViewController.addToBag(sender:)), for: .touchUpInside)
                    return cell
                }
        })
        // Устанавливаем хедр для секции
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else {
                return nil }
            guard let firstPart = self.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: firstPart) else {return nil }
            if section.title.isEmpty { return nil }
            sectionHeader.title.text = section.title
            return sectionHeader
        }
    }
    // Перезагружаем таблицу
    func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<MSection, MPart>()
        snapShot.appendSections(sectionsArray)
        
        for section in sectionsArray {
            snapShot.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(snapShot, animatingDifferences: true)
        
    }
    
    //MARK: - Setup Layout
    // Создаём layout таблицы из layout секций
    
    func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.sectionsArray[sectionIndex]
            
            switch section.type {
            case "CategoriParts":
                return self.createCategorySection()
            default:
                return self.createPartSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 50
        layout.configuration = config
        return layout
    }
    // Создание layout секции для категории
    func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 4, bottom: 0, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(self.view.bounds.size.width / 5), heightDimension: .estimated(self.view.bounds.size.width / 5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //        group.interItemSpacing = .fixed(spasing)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        //        section.interGroupSpacing = spasing
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 8, bottom: 0, trailing: 8)
        
        //        let layoutSectionHeader = createSectionHeadr()
        //        layoutSectionHeader.contentInsections = NSDirectionEdgeInsets.init(top: 0, leading: 5, bottom: 0, trailing: 0)
        //        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    // Создание layout секции для детали
    func createPartSection() -> NSCollectionLayoutSection {
        
        //           let spasing = CGFloat(20)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(self.view.bounds.size.width / 9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(2.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        //            group.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0)
        //           group.interItemSpacing = .fixed(spasing)
        let section = NSCollectionLayoutSection(group: group)
        //           section.interGroupSpacing = spasing
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 6, bottom: 0, trailing: 6)
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    // Создание layout для heder
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
}
