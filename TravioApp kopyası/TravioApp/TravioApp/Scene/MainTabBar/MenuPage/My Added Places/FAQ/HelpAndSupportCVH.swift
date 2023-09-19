//
//  HelpAndSupportCVH.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 12.09.2023.
//

import UIKit

final class HelpAndSupportCVH: UICollectionReusableView {
    //MARK: - Views
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "FAQ"
        label.font = Font.poppins(fontType: 600, size: 24).font
        label.textColor = ColorEnum.travioBackground.uiColor
        return label
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setupView(){
        addSubviews(header)
        setupLayouts()
    }
    
    private func setupLayouts() {
        header.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
}
