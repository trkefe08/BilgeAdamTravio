//
//  UIView+Extension.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views:UIView...){
        views.forEach({
            self.addSubview($0)
        })
    }
    
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension Optional {
    
    func ifNil(_ default:Wrapped) -> Wrapped {
        return self ?? `default`
    }
}

extension String {
    var dateFormatter: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: self)
    }
}
