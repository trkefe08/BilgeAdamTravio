//
//  VisitCVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 30.08.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class VisitCVC: UICollectionViewCell {
    //MARK: - Views
    private lazy var containerView:UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var backgroundImage:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "istanbul")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var locationImage:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "visits_locationMark2")
        
        return img
    }()
    
    lazy var name:UILabel = {
        let lbl = UILabel()
        lbl.text = "placeName"
        lbl.font = Font.poppins(fontType: 300, size: 16).font
        lbl.textColor = .white
        return lbl
    }()
    
    lazy var title:UILabel = {
        let lbl = UILabel()
        lbl.text = "placeName"
        lbl.font = Font.poppins(fontType: 600, size: 30).font
        lbl.textColor = .white
        return lbl
    }()

    private lazy var gradient:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "gradient")
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft, .topRight, .bottomLeft],
                                    cornerRadii: CGSize(width: 16, height: 16))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    //MARK: - Functions
    private func setupViews() {
        self.isSkeletonable = true
        contentView.isSkeletonable = true
        containerView.isSkeletonable = true
        backgroundImage.isSkeletonable = true
        locationImage.isSkeletonable = true
        name.isSkeletonable = true
        title.isSkeletonable = true
        gradient.isSkeletonable = true
        addSubviews(containerView)
        containerView.addSubviews(backgroundImage,gradient,locationImage,name,title)
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(142)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        
        }
        
        locationImage.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(20)
            make.width.equalTo(15)
        }
        
        name.snp.makeConstraints { make in
            make.leading.equalTo(locationImage.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(title.snp.bottom)
        }
        
        gradient.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().offset(0)
            make.height.equalTo(110)
        }
    }

    func configure(with travel: Visit) {
        name.text = travel.place?.place
        title.text = travel.place?.title
        guard let image = URL(string: travel.place?.coverImageURL ?? "not found") else { return }
        backgroundImage.kf.indicatorType = .activity
        backgroundImage.kf.setImage(with: image)
    }
}
