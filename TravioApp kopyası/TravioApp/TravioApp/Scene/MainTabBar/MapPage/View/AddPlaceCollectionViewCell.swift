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
    private lazy var rectangleView: UIView = {
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
        
        layoutIfNeeded()
        rectangleView.roundCorners(corners: [.bottomLeft, .topLeft, .topRight], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func setupViews() {
        self.contentView.backgroundColor = .clear
        self.contentView.addSubviews(rectangleView)
        self.rectangleView.addSubviews(placeImage,addPhotoImage)
        setupLayout()
    }
    
    private func setupLayout() {
        rectangleView.leadingToSuperview(offset: 24)
        rectangleView.trailingToSuperview(offset: 24)
        rectangleView.topToSuperview()
        rectangleView.bottomToSuperview()
        
        placeImage.edgesToSuperview()
        
        addPhotoImage.centerXToSuperview()
        addPhotoImage.centerYToSuperview()
        addPhotoImage.height(58)
        addPhotoImage.width(62)
        addPhotoImage.bringSubviewToFront(placeImage)
    }
}
