//
//  HelpAndSupportCVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 8.09.2023.
//

import UIKit

class HelpAndSupportCVC: UICollectionViewCell {
    
    var isAnswerHidden = false
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private lazy var question:UILabel = {
        let lbl = UILabel()
        lbl.text = "Question"
        lbl.font = Font.poppins(fontType: 500, size: 14).font
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    private lazy var answer:UILabel = {
        let lbl = UILabel()
        lbl.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu enim sed nisi condimentum tristique nec ac sapien. Etiam ultrices elit egestas sodales sagittis. Nulla facilisi. Nam vitae rhoncus urna. Duis ut pretium ligula. Nunc rhoncus nec augue nec malesuada. Mauris vulputate ante sed rutrum euismod. Duis vitae ligula nec elit condimentum ultricies vitae et ipsum. Maecenas dignissim tortor sit amet massa varius suscipit."
        lbl.numberOfLines = 0
        lbl.font = Font.poppins(fontType: 300, size: 10).font
        
        return lbl
    }()
    private lazy var image: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "faq_button")
        
        return image
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
    
    func configure(model:FAQ) {
        question.text = model.question
        answer.text = model.answer
    }
    
    func setupView(){
        addSubview(containerView)
        containerView.addSubviews(question,answer,image)
        setupLayouts()
    }
    
    func setupLayouts() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-18.5)
            make.center.equalTo(question)
            make.height.equalTo(10.4)
            make.width.equalTo(15.5)
        }
        
        question.snp.makeConstraints { make in
            make.trailing.equalTo(image.snp.leading).offset(-12)
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(16)
        }
        
        answer.snp.makeConstraints { make in
            make.top.equalTo(question.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
}
