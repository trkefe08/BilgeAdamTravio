//
//  AddPlaceCollectionViewCell.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//
import UIKit
//MARK: - Class
final class AddPlaceCollectionViewCell: UICollectionViewCell {
    //MARK: - Views
    lazy var rectangleView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var placeImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var addPhotoImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "addphoto")
        return img
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        placeImage.layoutIfNeeded()
        placeImage.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setupViews() {
        self.contentView.backgroundColor = .clear
        self.rectangleView.roundCornersWithShadow([.topLeft,.topRight, .bottomLeft], radius: 16)
        self.contentView.addSubviews(rectangleView)
        self.rectangleView.addSubviews(placeImage, addPhotoImage)
        setupLayout()
    }
    
    private func setupLayout() {
        rectangleView.leadingToSuperview()
        rectangleView.trailingToSuperview()
        rectangleView.topToSuperview(offset: 8)
        rectangleView.bottomToSuperview(offset: -8)
        
        placeImage.edgesToSuperview()
        
        addPhotoImage.centerXToSuperview()
        addPhotoImage.centerYToSuperview()
        addPhotoImage.height(58)
        addPhotoImage.width(62)
        addPhotoImage.bringSubviewToFront(placeImage)
    }
}
