//
//  TermOfUseVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 8.09.2023.
//

import UIKit

class TermOfUseVC: UIViewController {
    
    private lazy var retangle:CustomBackgroundRectangle = {
        let view = CustomBackgroundRectangle()
        
        return view
    }()
    
    private lazy var backButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        return button
    }()

    private lazy var header:UILabel = {
       let label = UILabel()
        label.text = "Term of Use"
        label.font = Font.poppins(fontType: 600, size: 32).font
        label.textColor = .white

        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView(){
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        
        view.addSubviews(retangle,backButton,header)
        setupLayouts()
    }
    
    func setupLayouts() {
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(36)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(21.5)
            make.width.equalTo(24)
        }

        header.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(24)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(23)
        }

        retangle.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(54)
            make.leading.trailing.bottom.equalToSuperview()
        }

        
    }
    
    
}
