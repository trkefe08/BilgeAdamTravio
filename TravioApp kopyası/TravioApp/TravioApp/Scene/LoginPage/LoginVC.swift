//
//  ViewController.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import TinyConstraints

class LoginVC: UIViewController {
    private lazy var LoginViewModelInstance: LoginViewModel = {
        let view = LoginViewModel()
        
        return view
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "travio-logo 1")
        
        return logo
    }()
    
    private lazy var retangle: CustomBackgroundRetangle = {
        let view = CustomBackgroundRetangle()
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = ColorEnum.travioBackground.uiColor
        view.addSubview(logo)
        view.addSubview(retangle)
        retangle.addSubview(welcomeLabel)
        retangle.addSubview(txtMailView)
        retangle.addSubview(txtPasswordView)
        retangle.addSubview(loginButton)
        retangle.addSubview(forgotStackView)
        forgotStackView.addArrangedSubview(accLabel)
        forgotStackView.addArrangedSubview(signUp)
        setupLayouts()
    }
    
    func setupLayouts() {
        navigationController?.isNavigationBarHidden = true
        
        logo.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(44)
            make.centerX.equalToSuperview()
            make.height.equalTo(178)
            make.width.equalTo(150)
        }
        
        retangle.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(retangle.snp.top).offset(64)
            make.centerX.equalToSuperview()
        }
        
        txtMailView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(41)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(74)
        }
        
        txtPasswordView.snp.makeConstraints { make in
            make.top.equalTo(txtMailView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(74)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(txtPasswordView.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(54)
        }
        
        forgotStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-21)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func signUpTapped() {
        let vc = SignUpVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func loginButtonTapped() {
        guard let email = txtMailView.txtField.text else { return }
        guard let password = txtPasswordView.txtField.text else { return }
        
        let data = LoginInfo(email: email, password: password)
        
        LoginViewModelInstance.login(params: ["email":email, "password":password] ) { error in
            if let error = error {
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




