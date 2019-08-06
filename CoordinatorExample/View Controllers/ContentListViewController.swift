//
//  ContentListViewController.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/20/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

protocol ContentListViewControllerRouter: class {
    func didSelect(contentListItem: ContentListItem, viewController: ContentListViewController)
    func finish()
}

final class ContentListViewController: FullCollectionViewController {
    // MARK: - Public properties
    weak var router: ContentListViewControllerRouter?
    
    // MARK: - ShowsLoading protocol
    let loadingView = LoadingView()
    
    // MARK: - Private Properties
    private var dataProvider: ContentListDataProvider?
    private var models: [ContentListItem]?
    
    // MARK: - Factory
    static func make(models: [ContentListItem]?) -> ContentListViewController {
        let viewController = ContentListViewController()
        viewController.models = models
        return viewController
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        dataProvider = ContentListDataProvider(
            collection: collectionView,
            models: models
        )
        dataProvider?.delegate = self
        
        super.viewDidLoad()
        
        setupLoadingView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.title = LocalizedStrings.contentList
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            router?.finish()
        }
    }
    
    // MARK: - Public methods
    func update(items: [ContentListItem]) {
        dataProvider?.set(listModels: items)
    }
}

extension ContentListViewController: ContentListDataProviderDelegate {
    func dataProvider(_ dataProvider: ContentListDataProvider, didSelect item: ContentListItem) {
        router?.didSelect(contentListItem: item, viewController: self)
    }
}

extension ContentListViewController: ShowsLoading { }


