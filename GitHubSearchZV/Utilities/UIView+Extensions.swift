//
//  UIView+Extensions.swift
//  GitHubSearchZV
//
//  Created by Zoltan Vinkler on 2022. 04. 12..
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}
