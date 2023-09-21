//
//  AppDefaultsVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 15.09.2023.
//

import UIKit

class AppDefaultsVC: UIViewController {
    //MARK: - Views
    private lazy var rectangleView:CustomBackgroundRectangle = {
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
        label.text = "App Defaults"
        label.font = Font.poppins(fontType: 600, size: 32).font
        label.textColor = .white
        
        return label
    }()
    
   
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
      
    }

    private func setupViews(){
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        self.view.addSubviews(rectangleView,backButton,header)
        setupLayout()
    }
    
    private func setupLayout() {
        backButton.topToSuperview(offset: 36, usingSafeArea: true)
        backButton.leadingToSuperview(offset: 20)
        backButton.height(21.5)
        backButton.width(24)

        header.leadingToTrailing(of: backButton, offset: 24)
        header.topToSuperview(offset: 23, usingSafeArea: true)
        
        rectangleView.topToBottom(of: header, offset: 54)
        rectangleView.leadingToSuperview()
        rectangleView.trailingToSuperview()
        rectangleView.bottomToSuperview()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}
