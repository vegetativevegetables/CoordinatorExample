//
//  ConstraintsUpdating.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

protocol ConstraintsUpdating: class {
    var allConstraints: [NSLayoutConstraint] { get set }
    func setup(constraints: [NSLayoutConstraint])
}

extension ConstraintsUpdating {
    func setup(constraints: [NSLayoutConstraint]) {
        if !allConstraints.isEmpty {
            NSLayoutConstraint.deactivate(allConstraints)
            allConstraints.removeAll()
        }
        
        allConstraints += constraints
        
        NSLayoutConstraint.activate(allConstraints)
    }
}
