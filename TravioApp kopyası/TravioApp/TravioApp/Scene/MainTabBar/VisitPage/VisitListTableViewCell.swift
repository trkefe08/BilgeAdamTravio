//
//  VisitListTableViewCell.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

class VisitListTableViewCell: UITableViewCell {
    var indexPath: IndexPath?
    
    private lazy var visitImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var rectangleView: UIView = {
        let v = UIView()
        let colors: [UIColor] = [#colorLiteral(red: 0.2605186105, green: 0.2605186105, blue: 0.2605186105, alpha: 0), #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)]
        let gradientColor = UIColor.applyGradient(colors: colors, bounds: CGRect(x: 0, y: 0, width: 344, height: 110))
        v.backgroundColor = gradientColor
        return v
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
    
    private lazy var visitNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-Regular", size: 16)
        return lbl
    }()
    
    var imageLoadCompletion: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.contentView.addSubviews(visitImage,rectangleView,stackView)
        self.contentView.backgroundColor = .clear
        
        stackView.addArrangedSubviews(iconImage, visitNameLabel)
        setupLayout()
    }
    
    override func layoutSubviews() {
        visitImage.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 16)
        
        
    }
    
    func setupLayout() {
        
        visitImage.edgesToSuperview(insets: .bottom(16))
        
        rectangleView.edgesToSuperview(excluding: .top,insets: .bottom(16))
        rectangleView.height(110)
        rectangleView.bringSubviewToFront(visitImage)
        
        iconImage.width(15)
        
        
        stackView.leadingToSuperview(offset:8)
        stackView.bottom(to: rectangleView,offset: -8)
        stackView.bringSubviewToFront(rectangleView)
        
    }
    
    
    func configureCell(model: PlaceVisit) {
        //        guard let image = URL(string: model.imageURL ?? "Not found") else { return }
        //        visitImage.kf.setImage(with: image) { result in
        //            switch result {
        //            case .success(_):
        //                completion?() // Resim yüklendiğinde completion closure'ını çağır
        //            case .failure(_):
        //                break
        //            }
        //        }
        visitNameLabel.text = model.title
    }
    
    //    func resetContent() {
    //        visitImage.image = nil
    //        imageLoadCompletion = nil
    //        visitNameLabel.text = nil
    //        // Diğer içerikleri de sıfırlayın
    //    }
    
    func loadImage(with url: String?, completion: @escaping (IndexPath) -> Void) {
        guard let url = URL(string: url ?? ""), let indexPath = indexPath else {
            return
        }
        
        // Kingfisher kullanarak resmi yükle
        self.visitImage.kf.setImage(with: url) { [weak self] result in
            // Resim yükleme işlemi tamamlandığında, completion bloğunu çağırarak indexPath'yi iletebiliriz
            switch result {
            case .success(_):
                completion(indexPath)
            case .failure(_):
                break // Hata durumu işlenmiyor
            }
        }
    }
}
