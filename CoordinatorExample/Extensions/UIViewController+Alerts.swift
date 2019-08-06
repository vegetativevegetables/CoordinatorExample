//
//  UIViewController+Alerts.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

extension UIViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: LocalizedStrings.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.ok)
        present(alert, animated: true)
    }
    
    func showNetworkErrorAlert(error: Error) {
        let message: String
        if let requestError = error as? HTTPRequestError {
            message = requestError.description
        } else {
            message = LocalizedStrings.genericErrorMessage
        }
        showErrorAlert(message: message)
    }
    
    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach {
            alert.addAction($0)
        }
        present(alert, animated: true)
    }
}
