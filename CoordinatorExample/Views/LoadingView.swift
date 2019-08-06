//
//  LoadingView.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

final class LoadingView: UIView {

    static let animationDuration = 0.25
    
    // MARK: - ConstraintsUpdating protocol
    var allConstraints = [NSLayoutConstraint]()
    
    // MARK: - Private properties
    private let spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func updateConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints += [spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
                        spinner.centerYAnchor.constraint(equalTo: centerYAnchor)]
        
        setup(constraints: constraints)
        
        super.updateConstraints()
    }
    
    // MARK: - Private methods
    private func setup() {
        isOpaque = false
        backgroundColor = UIColor(white: 0.0, alpha: 0.40)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        
        spinner.startAnimating()
    }
}

extension LoadingView: ConstraintsUpdating { }
