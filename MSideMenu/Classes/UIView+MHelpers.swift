//
//  UIView+MHelpers.swift
//  Pods
//
//  Created by Esraa Apady on 3/28/17.
//
//

import Foundation
/**
    Helper to add UIView related helper method
*/
extension UIView {
    
    func applyShadow(_ color: UIColor, offset: CGSize, opacity: Float, radius: CGFloat) {
        let layer = self.layer
        let path = UIBezierPath(rect: layer.bounds)
        
        layer.shadowPath = path.cgPath
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius

    }
}
