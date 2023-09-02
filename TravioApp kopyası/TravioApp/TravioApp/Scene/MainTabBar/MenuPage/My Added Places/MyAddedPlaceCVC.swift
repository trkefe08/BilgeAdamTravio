//
//  MyAddedPlaceCVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 1.09.2023.
//

import SnapKit
import UIKit

class MyAddedPlaceCVC: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        backgroundColor = .white
        
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        setupLayouts()
    }
    
    func setupLayouts() {}

    
    func addShadow() {
        layer.shadowColor = UIColor.yellow.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 4
        clipsToBounds = false
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
      
}
