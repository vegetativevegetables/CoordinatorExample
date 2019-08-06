//
//  ShowsLoading.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

protocol ShowsLoading {
    var loadingView: LoadingView { get }
    func setupLoadingView()
    func showLoadingView()
    func hideLoadingView()
}

extension ShowsLoading where Self: UIViewController {
    func setupLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.alpha = 0
        view.addSubview(loadingView)
        loadingView.isHidden = true
    }
    
    func showLoadingView() {
        view.bringSubviewToFront(loadingView)
        self.loadingView.isHidden = false
        UIView.animate(withDuration: LoadingView.animationDuration) {
            self.loadingView.alpha = 1.0
        }
    }
    
    func hideLoadingView() {
        UIView.animate(withDuration: LoadingView.animationDuration, animations: {
            self.loadingView.alpha = 0
        }, completion: { _ in
            self.loadingView.isHidden = true
        })
    }
}

extension ShowsLoading where Self: FullViewController {
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints += fillingView?.constraintsToFillSuperview ?? []
        constraints += loadingView.constraintsToFillSuperview
        
        setup(constraints: constraints)
    }
}
