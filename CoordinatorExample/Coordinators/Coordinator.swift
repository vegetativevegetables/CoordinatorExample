//
//  Coordinator.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/20/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
