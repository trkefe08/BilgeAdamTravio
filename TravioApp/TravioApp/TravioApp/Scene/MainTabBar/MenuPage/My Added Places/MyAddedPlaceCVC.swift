//
//  MyAddedPlaceCVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 1.09.2023.
//

import SnapKit
import UIKit
import SDWebImage

class MyAddedPlaceCVC: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private lazy var placeImage: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleToFill
        
        return img
    }()
    
    private lazy var placeName: UILabel = {
       let lbl = UILabel()
        lbl.font = Font.poppins(fontType: 600, size: 24).font
        lbl.text = "Colleseum"
        lbl.textColor = ColorEnum.fontColor.uiColor
        
        return lbl
    }()
    
    private lazy var cityName: UILabel = {
       let lbl = UILabel()
        lbl.font = Font.poppins(fontType: 300, size: 14).font
        lbl.text = "Rome"
        lbl.textColor = ColorEnum.fontColor.uiColor
        
        return lbl
    }()
    
    private lazy var locationMark:UIImageView = {
       let mark = UIImageView()
        mark.image = #imageLiteral(resourceName: "myAddedPlace_locationMark")
        
        return mark
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
   
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 4
        clipsToBounds = false
    }

    func configure(item:MyAddedPlace) {
        placeName.text = item.title
        cityName.text = item.place
        
        let url = URL(string: item.coverImageUrl)
        placeImage.sd_setImage(with: url)
    }
  
    func setupView() {
        addSubview(containerView)
        containerView.addSubviews(placeImage,placeName,cityName,locationMark)
        setupLayouts()
    }
    
    func setupLayouts() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        placeImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(90)
        }
        
        placeName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(placeImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(8)
        }
        
        locationMark.snp.makeConstraints { make in
            make.top.equalTo(placeName.snp.bottom).offset(3)
            make.leading.equalTo(placeImage.snp.trailing).offset(8)
            make.height.equalTo(12)
            make.width.equalTo(9)
        }
        
        cityName.snp.makeConstraints { make in
            make.leading.equalTo(locationMark.snp.trailing).offset(6)
            make.centerY.equalTo(locationMark)
        }
    }
}
