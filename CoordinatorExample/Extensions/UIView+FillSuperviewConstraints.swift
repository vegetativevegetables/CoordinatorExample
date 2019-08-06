//
//  UIView+FillSuperviewConstraints.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

extension UIView {
    var constraintsToFillSuperview: [NSLayoutConstraint] {
        guard let superview = superview else { return [] }
        return [leftAnchor.constraint(equalTo: superview.leftAnchor),
                topAnchor.constraint(equalTo: superview.topAnchor),
                rightAnchor.constraint(equalTo: superview.rightAnchor),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor)]
    }
    
    func constraintsToFillSuperview(spacing: CGFloat) -> [NSLayoutConstraint] {
        guard let superview = superview else { return [] }
        return [leftAnchor.constraint(equalTo: superview.leftAnchor, constant: spacing),
                topAnchor.constraint(equalTo: superview.topAnchor, constant: spacing),
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -spacing),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -spacing)]
    }
}
