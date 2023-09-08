//
//  HelpAndSupportCVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 8.09.2023.
//

import UIKit

class HelpAndSupportCVC: UICollectionViewCell {
    
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
        
        return lbl
    }()
    
    private lazy var answer:UILabel = {
        let lbl = UILabel()
        lbl.text = "Answer"
        lbl.font = Font.poppins(fontType: 300, size: 10).font
        
        return lbl
    }()
    
    private lazy var button:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "faq_button"), for: .normal)
    
        return btn
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
    
    
    func setupView(){
        
        addSubview(containerView)
        containerView.addSubviews(question,answer,button)
        
        setupLayouts()
    }
    
    func setupLayouts() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-18.5)
            make.top.equalToSuperview().offset(32)
            make.height.width.equalTo(15)
           }
        
        question.snp.makeConstraints { make in
            make.trailing.equalTo(button.snp.leading).offset(-12)
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
