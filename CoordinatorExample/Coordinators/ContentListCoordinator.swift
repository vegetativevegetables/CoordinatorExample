//
//  ContentListCoordinator.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/20/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import Foundation

import UIKit

protocol ContentListDependencies {
    var contentListService: ContentListAPI { get }
}

struct ContentListServices: ContentListDependencies {
    let contentListService: ContentListAPI

    init() {
        contentListService = ContentListService()
    }
}

final class ContentListCoordinator: Coordinator {
    var childCoordinators: [Coordinator]

    private let presenter: UINavigationController
    private var dependencies: ContentListDependencies!

    private var contentListViewController: ContentListViewController?

    init(presenter: UINavigationController, dependencies: ContentListDependencies = ContentListServices()) {
        self.presenter = presenter
        self.dependencies = dependencies
        childCoordinators = []
    }
    
    func start() {
        let viewController = ContentListViewController.make(models: [])
        presenter.pushViewController(viewController, animated: true)
        self.contentListViewController = viewController

        downloadContentForViewController()
    }
}

private extension ContentListCoordinator {
    func downloadContentForViewController() {
        dependencies.contentListService.downloadContent { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let contentList):
                    self.onDownloadContentSuccess(contentList: contentList)
                case .failure(let error):
                    self.presenter.showErrorAlert(message: "Could not download items: \(error)")
                }
            }
        }
    }

    func onDownloadContentSuccess(contentList: ContentListResponse) {
        contentListViewController?.update(items: contentList.contentListItems)
    }
}
