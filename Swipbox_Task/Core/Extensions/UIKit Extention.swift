//
//  UIKit Extention.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import UIKit

//MARK: - UIView
extension UIView {
    func shadow(color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }
}
