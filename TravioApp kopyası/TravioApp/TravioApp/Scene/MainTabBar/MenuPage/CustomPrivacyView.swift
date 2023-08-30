//
//  CustomPrivacyView.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 29.08.2023.
//

import UIKit

class CustomPrivacyView: UIView {
    
    var labelText = "" {
        didSet {
            
            label.text = labelText
        }
    }

    private lazy var label: UILabel = {
       let label = UILabel()
        label.text = "Deneme"
        label.font = Font.poppins(fontType: 500, size: 14).font
        
        return label
    }()

    private lazy var switchComponent: UISwitch = {
       let swt = UISwitch()
        swt.isOn = false
        
        
        return swt
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
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
        
    func setupViews() {
        addShadow()
        
        addSubviews(label,switchComponent)
        setupLayouts()
    }
        
    func setupLayouts() {
       
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        switchComponent.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
       
    }
}
