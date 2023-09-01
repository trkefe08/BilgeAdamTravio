//
//  CustomTF.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 29.08.2023.
//

import SnapKit
import UIKit

class CustomTF: UIView {
    
    var isSecure = true {
        didSet {
            txtField.isSecureTextEntry = true
        }
    }
    
    
    var placeholderName = "" {
        didSet {
            txtField.placeholder = placeholderName
        }
    }
        
    var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.font = Font.poppins(fontType: 500, size: 14).font
            
        return label
    }()
        
    lazy var txtField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "placeholder"
        txt.font = Font.poppins(fontType: 300, size: 12).font
        txt.autocorrectionType = .no
        txt.autocapitalizationType = .none
            
        return txt
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
        addSubview(label)
        addSubview(txtField)
        setupLayouts()
    }
        
    func setupLayouts() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(100)
        }
            
        txtField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-19)
        }
    }
}
