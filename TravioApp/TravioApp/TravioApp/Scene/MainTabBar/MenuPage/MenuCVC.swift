//
//  MenuCVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 29.08.2023.
//

import UIKit
import SnapKit

class MenuCVC: UICollectionViewCell {
    
    private lazy var bView: UIView = {
         let view = UIView()
         view.backgroundColor = .white
         view.layer.cornerRadius = 16
         view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
         view.layer.shadowColor = UIColor.black.cgColor
         view.layer.shadowOffset = CGSize(width: 0, height: 0)
         view.layer.shadowOpacity = 0.15
         view.layer.shadowRadius = 4
         return view
     }()

    private lazy var image: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "settings_profile")
        
        return image
    }()
    
    private lazy var settingsName: UILabel = {
      let label = UILabel()
        label.text = "Security Settings"
        label.font = Font.poppins(fontType: 300, size: 14).font
        
        return label
    }()
    
    private lazy var vector: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "settings_vector")
        
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
            setupView()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }

    func configure(item:settingsCVS) {
        image.image = UIImage(named: item.image)
        settingsName.text = item.name
    }
    
    
    
    func setupView(){
        addSubview(bView)
        bView.addSubviews(image,settingsName,vector)
    
        setupLayouts()
    }
    
    func setupLayouts() {
        
        bView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(3)
            make.trailing.bottom.equalToSuperview().offset(-3)
        }
        
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(17)
            make.height.width.equalTo(20)
        }
        
        settingsName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(image.snp.trailing).offset(9)
        }

        vector.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-17)
            make.height.equalTo(15.5)
            make.width.equalTo(10.5)
        }
    }
    
}
