//
//  FullViewController.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

// A view controller that takes a single view,
// adds it as a subview to its view, and
// sets constraints for it to fill the screen.
class FullViewController: UIViewController {
    
    // MARK: - Public Properties
    var fillingView: UIView?
    
    // MARK: - ConstraintsUpdating protocol
    var allConstraints = [NSLayoutConstraint]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
    // MARK: - Private methods
    private func setup() {
        fillingView?.backgroundColor = .lightGray
        
        fillingView?.translatesAutoresizingMaskIntoConstraints = false
        
        if let fillingView = fillingView {
            view.addSubview(fillingView)
        }
    }
    
    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints += fillingView?.constraintsToFillSuperview ?? []
        
        setup(constraints: constraints)
    }
}

extension FullViewController: ConstraintsUpdating { }
