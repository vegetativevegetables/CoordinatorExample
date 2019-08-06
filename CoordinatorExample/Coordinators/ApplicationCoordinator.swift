//
//  ApplicationCoordinator.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/20/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: Coordinator {

    var childCoordinators: [Coordinator]

    let window: UIWindow
    let presenter: UINavigationController

    init(window: UIWindow) {
        self.window = window

        let navigationController = UINavigationController()
        
        presenter = navigationController
        childCoordinators = []
    }

    func start() {
        window.rootViewController = presenter
        window.makeKeyAndVisible()

        let contentList = ContentListCoordinator(presenter: presenter)
        childCoordinators.append(contentList)
        contentList.start()
    }
}
