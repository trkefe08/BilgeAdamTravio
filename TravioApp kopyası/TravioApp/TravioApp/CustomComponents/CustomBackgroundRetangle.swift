//
//  CustomBackgroundRetangle.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 29.08.2023.
//

import Foundation
import UIKit

class CustomBackgroundRetangle: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorEnum.viewColor.uiColor // Beyaz rengi tanımladığın bir yer olmalı
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft], // Burada istediğin köşeyi seçebilirsin
                                    cornerRadii: CGSize(width: 80, height: 80))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
