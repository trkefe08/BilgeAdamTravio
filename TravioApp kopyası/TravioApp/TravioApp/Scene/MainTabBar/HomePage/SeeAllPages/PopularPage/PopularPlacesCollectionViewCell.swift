//
//  PopularPlacesCollectionViewCell.swift
//  TravioApp
//
//  Created by Tarik Efe on 8.09.2023.
//
import UIKit
import TinyConstraints
import Kingfisher

final class PopularPlacesCollectionViewCell: UICollectionViewCell {
    //MARK: - Views
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
        lbl.textColor = ColorEnum.fontColor.uiColor
        return lbl
    }()
    
    private lazy var cityName: UILabel = {
        let lbl = UILabel()
        lbl.font = Font.poppins(fontType: 300, size: 14).font
        lbl.textColor = ColorEnum.fontColor.uiColor
        return lbl
    }()
    
    private lazy var locationMark:UIImageView = {
        let mark = UIImageView()
        mark.image = #imageLiteral(resourceName: "myAddedPlace_locationMark")
        return mark
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //MARK: - Functions
    private func addShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 4
        clipsToBounds = false
    }
    
    func configure(item: MyAddedPlace) {
        placeName.text = item.title
        cityName.text = item.place
        guard let image = URL(string: item.coverImageUrl ) else { return }
        placeImage.kf.indicatorType = .activity
        placeImage.kf.setImage(with: image)
    }
    
    private func setupViews() {
        self.contentView.addSubview(containerView)
        self.containerView.addSubviews(placeImage,placeName,cityName,locationMark)
        setupLayouts()
    }
    
    private func setupLayouts() {
        containerView.edgesToSuperview()
        
        placeImage.topToSuperview()
        placeImage.leadingToSuperview()
        placeImage.bottomToSuperview()
        placeImage.width(90)
        
        placeName.topToSuperview(offset: 16)
        placeName.leadingToTrailing(of: placeImage, offset: 8)
        placeName.trailingToSuperview(offset: 8)
        
        locationMark.topToBottom(of: placeName, offset: 3)
        locationMark.leadingToTrailing(of: placeImage, offset: 8)
        locationMark.height(12)
        locationMark.width(9)
        
        cityName.leadingToTrailing(of: locationMark, offset: 6)
        cityName.centerY(to: locationMark)
    }
}


