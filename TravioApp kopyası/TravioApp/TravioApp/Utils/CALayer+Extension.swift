//
//  CALayer+Extension.swift
//  TravioApp
//
//  Created by Tarik Efe on 5.09.2023.
//

import UIKit

extension CALayer {
    func applyCornerRadiusShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0,
        cornerRadiusValue: CGFloat = 16,
        corners: UIRectCorner = .topLeft // Default olarak tüm köşelere yuvarlak köşe uygula
    ) {
        cornerRadius = cornerRadiusValue
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            
            let cornerRadii = CGSize(width: cornerRadiusValue, height: cornerRadiusValue)
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: cornerRadii)
            
            shadowPath = path.cgPath
        }
    }
}
