//
//  HelpAndSupportCVH.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 12.09.2023.
//

import UIKit
import SnapKit

class HelpAndSupportCVH: UICollectionReusableView {

    private lazy var label: UILabel = {
            let lbl = UILabel()
            lbl.text = "FAQ"
            lbl.font = Font.poppins(fontType: 600, size: 24).font
            lbl.textColor = ColorEnum.travioBackground.uiColor
            return lbl
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func setupView(){
        addSubview(label)
        
        setupLayouts()
    }
    
    func setupLayouts() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}
