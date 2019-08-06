//
//  CollectionViewDataProvider.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

protocol CollectionViewDataProvider: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var collectionView: UICollectionView? { get set }
    associatedtype ModelType
    var models: [ModelType]? { get set }
}

extension CollectionViewDataProvider {
    func set(listModels: [ModelType]) {
        models = listModels
        collectionView?.reloadData()
    }
    
    func append(listModels: [ModelType]) {
        if var current = models {
            current.append(contentsOf: listModels)
            models = current
        } else {
            models = listModels
        }
        collectionView?.reloadData()
    }
    
    func reload() {
        collectionView?.reloadData()
    }
}
