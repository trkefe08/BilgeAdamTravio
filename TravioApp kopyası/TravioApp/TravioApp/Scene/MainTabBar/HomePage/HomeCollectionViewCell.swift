//
//  HomeCollectionViewCell.swift
//  TravioApp
//
//  Created by Tarik Efe on 6.09.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    //MARK: - Views
    private lazy var mainImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var gradientView: UIView = {
        let v = UIView()
        let colors: [UIColor] = [#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 0), #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1)]
        let gradientColor = UIColor.applyGradient(colors: colors, bounds: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 88.59))
        v.backgroundColor = gradientColor
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Font.poppins(fontType: 600, size: 24).font
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
        img.image = #imageLiteral(resourceName: "visits_locationMark2")
        return img
    }()
    
    private lazy var placeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Font.poppins(fontType: 300, size: 14).font
        lbl.textColor = .white
        return lbl
    }()
    //MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func setupViews() {
        self.radiusWithShadow(corners: [.topLeft,.topRight,.bottomLeft])
        self.contentView.backgroundColor = ColorEnum.viewColor.uiColor
        self.contentView.addSubviews(mainImage)
        self.stackView.addArrangedSubviews(iconImage, placeLabel)
        self.mainImage.addSubviews(gradientView,titleLabel,stackView)
        setupLayout()
    }
    
    private func setupLayout() {
        mainImage.edgesToSuperview()
        
        gradientView.leadingToSuperview()
        gradientView.trailingToSuperview()
        gradientView.bottomToSuperview()
        gradientView.height(88.59)
        gradientView.bringSubviewToFront(mainImage)
        
        titleLabel.leadingToSuperview(offset: 16)
        titleLabel.bottomToSuperview(offset: -26)
        titleLabel.bringSubviewToFront(gradientView)
        
        stackView.topToBottom(of: titleLabel)
        stackView.leading(to: titleLabel)
        stackView.trailingToSuperview(offset: 8)
        stackView.bottomToSuperview(offset: -5)
        
        iconImage.height(12)
        iconImage.width(9)
        stackView.bringSubviewToFront(gradientView)
    }
    
    func configureCell(model: Place) {
        guard let image = URL(string: model.coverImageURL ?? "Not found") else { return }
        mainImage.kf.indicatorType = .activity
        mainImage.kf.setImage(with: image)
        titleLabel.text = model.title
        placeLabel.text = model.place
    }
}
