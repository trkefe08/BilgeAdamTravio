//
//  VisitDetailCVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 31.08.2023.
//

import UIKit
import SnapKit
import SDWebImage

final class VisitDetailCVC: UICollectionViewCell {
    
    private lazy var detailImage:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "istanbul")
        
        return img
    }()
    
    private lazy var retangle2:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "gradient2")
        
        return img
    }()
   
    override init(frame: CGRect) {
        super .init(frame: frame)
       backgroundColor = .orange
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        
    }
    
    func configure(model: String) {
        guard let image = URL(string: model) else {return}
        detailImage.sd_setImage(with: image)
    }

    func setupViews() {
        addSubviews(detailImage,retangle2)
        setupLayouts()
    }
    
    func setupLayouts() {
        
        detailImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        
        retangle2.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().offset(0)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
    
    }
}
