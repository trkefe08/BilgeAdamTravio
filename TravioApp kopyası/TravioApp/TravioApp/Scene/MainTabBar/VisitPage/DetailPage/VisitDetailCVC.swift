//
//  VisitDetailCVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 31.08.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class VisitDetailCVC: UICollectionViewCell {
    //MARK: - Views
    private lazy var detailImage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var retangle2:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "gradient2")
        return img
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        
    }
    //MARK: - Functions
    func configure(model: String) {
        if let image = URL(string: model) {
            detailImage.kf.indicatorType = .activity
            detailImage.kf.setImage(with: image)
        }
    }
    
    private func setupViews() {
        addSubviews(detailImage,retangle2)
        setupLayouts()
    }
    
    private func setupLayouts() {
        detailImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        
        retangle2.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().offset(0)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
}
