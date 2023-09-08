//
//  UICollectionViewCell+Extension.swift
//  TravioApp
//
//  Created by Tarik Efe on 7.09.2023.
//

import UIKit

extension UICollectionViewCell {
    
    func radiusWithShadow(corners:UIRectCorner){
        
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), byRoundingCorners: corners, cornerRadii: CGSize(width: 16, height: 16))
        rectanglePath.close()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 4
        layer.shadowPath = rectanglePath.cgPath
        contentView.roundCorners(corners: corners, radius: 16)
        contentView.layer.masksToBounds = true
    }
}
