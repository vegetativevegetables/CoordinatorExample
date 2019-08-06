//
//  UIView+HeightForLabel.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

extension UILabel {
    static func heightForLabel(width: CGFloat, text: String?, font: UIFont, numberOfLines: Int) -> CGFloat {
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        tempLabel.numberOfLines = numberOfLines
        tempLabel.text = text
        tempLabel.font = font
        tempLabel.sizeToFit()
        return tempLabel.frame.height
    }
}
