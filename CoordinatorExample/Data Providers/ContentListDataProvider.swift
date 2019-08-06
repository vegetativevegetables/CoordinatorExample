//
//  ContentListDataProvider.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

protocol ContentListDataProviderDelegate: class {
    func dataProvider(_ dataProvider: ContentListDataProvider, didSelect item: ContentListItem)
}

final class ContentListDataProvider: NSObject {
    private enum Sections: Int, CaseIterable {
        case items = 0
    }

    internal weak var collectionView: UICollectionView?
    internal var models: [ContentListItem]?
    weak var delegate: ContentListDataProviderDelegate?
    
    init(
        collection: UICollectionView,
        models: [ContentListItem]?
    ) {
        collectionView = collection
        self.models = models
        super.init()

        guard let cView = collectionView else { return }
        cView.delegate = self
        cView.dataSource = self
        cView.register(
            ContentListItemCollectionViewCell.self,
            forCellWithReuseIdentifier: ContentListItemCollectionViewCell.identifier
        )

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8 * 1.5
        cView.collectionViewLayout = flowLayout
        cView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension ContentListDataProvider: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == Sections.items.rawValue else { return }
        guard let items = models else { return }
        guard items.count > indexPath.row else { return }
        let model = items[indexPath.row]
        delegate?.dataProvider(self, didSelect: model)
    }
}

extension ContentListDataProvider: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let models = models else { return 0 }
        switch section {
        case Sections.items.rawValue:
            return models.count
        default: return 0
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt
        indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case Sections.items.rawValue:
            guard let models = models else {
                return UICollectionViewCell()
            }
            let model = models[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContentListItemCollectionViewCell.identifier,
                for: indexPath
                ) as? ContentListItemCollectionViewCell else {
                    return UICollectionViewCell()
            }
            cell.configure(viewModel: ContentListItemCollectionViewCellViewModel(contentListItem: model))
            return cell
        default: return UICollectionViewCell()
        }
    }
}

extension ContentListDataProvider: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.size.width - 8.0 * 2
        
        switch indexPath.section {
        case Sections.items.rawValue:
            guard let models = models else { return .zero }
            let model = models[indexPath.row]
            let viewModel = ContentListItemCollectionViewCellViewModel(contentListItem: model)
            return CGSize(
                width: width,
                height: ContentListItemCollectionViewCell.heightForCell(width: width, viewModel: viewModel)
            )
        default: return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let spacing: CGFloat = 8.0
        return UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        // Performance optimization
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
}

extension ContentListDataProvider: CollectionViewDataProvider {
    typealias ModelType = ContentListItem
}

