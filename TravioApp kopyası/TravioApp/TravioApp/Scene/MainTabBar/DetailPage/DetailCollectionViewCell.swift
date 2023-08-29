//
//  DetailCollectionViewCell.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

class DetailCollectionViewCell: UICollectionViewCell {
    
    private lazy var imgHeader: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var rectangleView: UIView = {
        let v = UIView()
        let colors: [UIColor] = [#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 0), #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)]
        let gradientColor = UIColor.applyGradient(colors: colors, bounds: CGRect(x: 0, y: 0, width: 390, height: 110))
        v.backgroundColor = gradientColor
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.backgroundColor = .clear
        self.contentView.addSubviews(imgHeader, rectangleView)
        setupLayout()
    }
    
    func setupLayout() {
        
        imgHeader.edgesToSuperview()
        rectangleView.edgesToSuperview(excluding: [.top])
        rectangleView.height(110)
        
        rectangleView.bringSubviewToFront(imgHeader)
    }
    
    func configureCell(model: Image) {
        guard let image = URL(string: model.imageURL ?? "Not found") else { return }
        imgHeader.kf.setImage(with: image)
        
    }
    
}
