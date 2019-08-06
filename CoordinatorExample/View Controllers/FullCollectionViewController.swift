//
//  CustomCollectionViewController.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

class FullCollectionViewController: FullViewController {

    // MARK: - Public Properties
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    override func viewDidLoad() {
        fillingView = collectionView
        super.viewDidLoad()
    }
}
