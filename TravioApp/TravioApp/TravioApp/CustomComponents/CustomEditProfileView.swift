//
//  CustomEditProfileView.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 31.08.2023.
//

import UIKit

class CustomEditProfileView: UIView {
    
    var labelText = "" {
        didSet {
            label.text = labelText
        }
    }
    
    var newImage = UIImage() {
        didSet {
         
            image.image = newImage
        }
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.font = Font.poppins(fontType: 500, size: 12).font
            
        return label
    }()
    
    private lazy var image:UIImageView = {
       let image = UIImageView()
        
        
       return image
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
            
        setupViews()
    }
        
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func addShadow() {
        layer.shadowColor = ColorEnum.shadowColor.uiColor?.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 4
        clipsToBounds = false
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
        
    func setupViews() {
        addShadow()
        addSubviews(image,label)
        setupLayouts()
    }
        
    func setupLayouts() {
        image.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(image.snp.trailing).offset(8)
        }
    }
}
