//
//  MapCollectionViewCell.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

//MARK: - Class
class MapCollectionViewCell: UICollectionViewCell {
    //MARK: - Views
    private lazy var mainImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 24)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillProportionally
        sv.spacing = 6
        sv.axis = .horizontal
        return sv
    }()
    
    private lazy var iconImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "white")
        return img
    }()
    
    private lazy var placeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-Regular", size: 14)
        return lbl
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        mainImage.layoutIfNeeded()
        mainImage.roundCorners(corners: [.bottomLeft, .topLeft, .topRight], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
   private func setupViews() {
        self.contentView.backgroundColor = .clear
        self.contentView.addSubviews(mainImage, titleLabel, stackView)
        self.contentView.roundCorners(corners: [.bottomLeft, .topLeft, .topRight], radius: 16)
        stackView.addArrangedSubviews(iconImage, placeLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        
        mainImage.edgesToSuperview(excluding: [.left, .right])
        mainImage.leadingToSuperview(offset: 16)
        mainImage.trailingToSuperview(offset: 16)
        
        titleLabel.leadingToSuperview(offset: 22)
        titleLabel.bottomToTop(of: stackView, offset: 3)
        titleLabel.bringSubviewToFront(mainImage)
        
        iconImage.height(12)
        iconImage.width(9)
        stackView.leading(to: titleLabel)
        stackView.bottomToSuperview(offset: -8)
        stackView.bringSubviewToFront(mainImage)
    }
    
    func configureCell(model: Place) {
        titleLabel.text = model.title
        placeLabel.text = model.place
        guard let image = URL(string: model.coverImageURL ?? "Not found") else { return }
        mainImage.kf.indicatorType = .activity
        mainImage.kf.setImage(with: image)
        
    }
}
