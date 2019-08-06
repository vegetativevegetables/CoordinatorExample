//
//  UIAlertAction+CommonActions.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

extension UIAlertAction {
    static var ok: UIAlertAction {
        return UIAlertAction(title: LocalizedStrings.ok, style: .cancel, handler: nil)
    }
    
    static var cancel: UIAlertAction {
        return UIAlertAction(title: LocalizedStrings.cancel, style: .cancel, handler: nil)
    }
}

