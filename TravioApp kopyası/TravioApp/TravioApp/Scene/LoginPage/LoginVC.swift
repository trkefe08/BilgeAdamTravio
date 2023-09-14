//
//  ViewController.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import TinyConstraints

final class LoginVC: UIViewController {
    //MARK: - Views
    private lazy var LoginViewModelInstance: LoginViewModel = {
        let view = LoginViewModel()
        return view
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "travio-logo 1")
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    private lazy var rectangleView: CustomBackgroundRectangle = {
        let view = CustomBackgroundRectangle()
        
        return view
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Travio"
        label.font = Font.poppins(fontType: 500, size: 24).font
        label.textColor = ColorEnum.fontColor.uiColor
        
        return label
    }()
    
    private lazy var txtMailView: CustomTF = {
        let view = CustomTF()
        view.labelText = "Email"
        view.placeholderName = "bilgeadam@gmail.com"
        view.txtField.text = "dogucandurgun@gmail.com"
        
        return view
    }()
    
    private lazy var txtPasswordView: CustomTF = {
        let view = CustomTF()
        view.labelText = "Password"
        view.placeholderName = "*********"
        view.txtField.text = "dogucandurgun"
        view.txtField.isSecureTextEntry = true
        
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let btn = CustomButton()
        btn.labelText = "Login"
        
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var forgotStackView: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private lazy var accLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have any account?"
        label.font = Font.poppins(fontType: 600, size: 14).font
        
        return label
    }()
    
    private lazy var signUp: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = Font.poppins(fontType: 600, size: 14).font
        button.setTitleColor(.black, for: .normal)
        
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
        
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    //MARK: - Functions
    private func setupViews() {
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        self.view.addSubviews(logo, rectangleView)
        rectangleView.addSubviews(welcomeLabel, txtMailView, txtPasswordView, loginButton, forgotStackView)
        forgotStackView.addArrangedSubviews(accLabel, signUp)
        setupLayouts()
    }
    
    private func setupLayouts() {
        navigationController?.isNavigationBarHidden = true
        
        let screenHeight = UIScreen.main.bounds.height
        let rectangleViewHeightRatio: CGFloat = 598.0 / 844.0
        let rectangleViewHeight = screenHeight * rectangleViewHeightRatio
        
        logo.topToSuperview(offset: 44, usingSafeArea: true)
        logo.centerXToSuperview()
        logo.height(UIScreen.main.bounds.height * 0.21)
        logo.width(UIScreen.main.bounds.width * 0.38)
    
        
        
        rectangleView.topToBottom(of: logo, offset: 24)
        rectangleView.leadingToSuperview()
        rectangleView.trailingToSuperview()
        rectangleView.bottomToSuperview()
        
        welcomeLabel.topToSuperview(offset: rectangleViewHeight * 0.09)
        welcomeLabel.centerXToSuperview()
        
        txtMailView.topToBottom(of: welcomeLabel, offset: rectangleViewHeight * 0.08)
        txtMailView.leadingToSuperview(offset: 24)
        txtMailView.trailingToSuperview(offset: 24)
        txtMailView.height(74)
        
        
        txtPasswordView.topToBottom(of: txtMailView, offset: rectangleViewHeight * 0.048)
        txtPasswordView.leading(to: txtMailView)
        txtPasswordView.trailing(to: txtMailView)
        txtPasswordView.height(74)
        
        loginButton.topToBottom(of: txtPasswordView, offset: rectangleViewHeight * 0.064)
        loginButton.leading(to: txtPasswordView)
        loginButton.trailing(to: txtPasswordView)
        loginButton.height(54)
        
        forgotStackView.bottomToSuperview(offset: -rectangleViewHeight * 0.025)
        forgotStackView.centerXToSuperview()
        
    }
    
    @objc func signUpTapped() {
        let vc = SignUpVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginButtonTapped() {
        guard let email = txtMailView.txtField.text else { return }
        guard let password = txtPasswordView.txtField.text else { return }
        
        _ = LoginInfo(email: email, password: password)
        
        LoginViewModelInstance.login(params: ["email":email, "password":password] ) { error in
            if let _ = error {
                let alert = UIAlertController(title: "Hata!", message: "Kullanıcı Adı veya Şifre Hatalı", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yeniden Dene", style: .default, handler: nil))
                self.present(alert, animated: true)
            } else {
                let tabBarController = MainTabBarController()
                self.navigationController?.pushViewController(tabBarController, animated: true)
            }
        }
    }
}





