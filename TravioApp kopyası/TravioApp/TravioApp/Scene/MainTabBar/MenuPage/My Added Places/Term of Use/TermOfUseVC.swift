//
//  TermOfUseVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 8.09.2023.
//

import UIKit
import WebKit
import TinyConstraints

final class TermOfUseVC: UIViewController {
    //MARK: - Views
    private lazy var rectangleView:CustomBackgroundRetangle = {
        let view = CustomBackgroundRetangle()
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
    
    private lazy var webView: WKWebView = {
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    let dispatchGroup = DispatchGroup()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        webView.layoutIfNeeded()
        self.webView.roundCorners(corners: .topLeft, radius: 80)
        loadWebsite(urlString: "https://api.iosclass.live/terms")
    }
    //MARK: - Functions
    private func loadWebsite(urlString: String) {
        dispatchGroup.enter()
        DispatchQueue.global().async {
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                DispatchQueue.main.async {
                    self.webView.load(request)
                    self.dispatchGroup.leave()
                }
            }
        }
    }
    
    private func setupViews(){
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        self.view.addSubviews(rectangleView,backButton,header)
        self.rectangleView.addSubviews(webView)
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
        
        webView.edgesToSuperview()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
