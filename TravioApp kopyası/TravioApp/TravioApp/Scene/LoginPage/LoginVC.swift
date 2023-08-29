//
//  ViewController.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import TinyConstraints

class LoginVC: UIViewController {

    private lazy var imgHeader: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "travio-logo 1")
        return img
    }()
    
    private lazy var rectangleView: UIView = {
        let v = UIView()
        let selectedColor = ColorEnum.viewColor
        if let colorValue = selectedColor.uiColor {
            v.backgroundColor = colorValue
        }
        return v
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome to Travio"
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 24)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var usernameView: UIView = {
        let v = UIView()
        let selectedColor = ColorEnum.tfBackground
        if let colorValue = selectedColor.uiColor {
            v.backgroundColor = colorValue
        }
        return v
    }()
    
    private lazy var emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Email"
        let selectedColor = ColorEnum.fontColor
        if let colorValue = selectedColor.uiColor {
            lbl.textColor = colorValue
        }
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 14)
        return lbl
    }()
    
    private lazy var txtUserName: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "developer@bilgeadam.com"
        tf.text = "T@gmail.com"
        tf.delegate = self
        return tf
    }()
    
    private lazy var passwordView: UIView = {
        let v = UIView()
        let selectedColor = ColorEnum.tfBackground
        if let colorValue = selectedColor.uiColor {
            v.backgroundColor = colorValue
        }
        return v
    }()
    
    private lazy var passwordLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Password"
        let selectedColor = ColorEnum.fontColor
        if let colorValue = selectedColor.uiColor {
            lbl.textColor = colorValue
        }
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 14)
        return lbl
    }()
    
    private lazy var txtPassword:CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "************"
        tf.text = "12345678"
        tf.delegate = self
        return tf
    }()
    
    private lazy var btnNext:UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
        let selectedColor = ColorEnum.travioBackground
        if let colorValue = selectedColor.uiColor {
            button.backgroundColor = colorValue
        }
        button.addTarget(self, action: #selector(btnNextTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var stackView:UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillProportionally
        sv.spacing = 0
        sv.axis = .horizontal
        sv.alignment = .center
        return sv
        
    }()
    
    private lazy var lblSignUpTitle: UILabel = {
        let l = UILabel()
        l.text = "Don't have any account?"
        l.textAlignment = .right
        let selectedColor = ColorEnum.fontColor
        if let colorValue = selectedColor.uiColor {
            l.textColor = colorValue
        }
        l.font = UIFont(name: "Poppins-Bold", size: 14)
        return l
    }()
    
    private lazy var btnSignUp:UIButton = {
        let button = UIButton()
        let attrString = NSAttributedString(string: " Sign Up", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                                                                                   NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1)])
        
        button.setAttributedTitle(attrString, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 14)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(btnSignUpTapped), for: .touchUpInside)
        return button
    }()
    
    
    var viewModel = LoginViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        rectangleView.roundCorners(corners: .topLeft, radius: 80)
        usernameView.roundCorners(corners: [.topLeft, .bottomLeft, .topRight], radius: 16)
        passwordView.roundCorners(corners: [.topLeft, .bottomLeft, .topRight], radius: 16)
        btnNext.roundCorners(corners: [.topLeft, .bottomLeft, .topRight], radius: 12)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    @objc func btnNextTapped() {
        guard let username = txtUserName.text else { return }
        guard let password = txtPassword.text else { return }
        viewModel.login(params: ["email": username, "password": password])
        let vc = MainTabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnSignUpTapped(){
        
        let vc = SignUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupViews(){
        
        let selectedColor = ColorEnum.travioBackground
        if let colorValue = selectedColor.uiColor {
            view.backgroundColor = colorValue
        }
        
        
        stackView.addArrangedSubview(lblSignUpTitle)
        stackView.addArrangedSubview(btnSignUp)
        
        self.view.addSubviews(imgHeader,rectangleView)
        
        self.rectangleView.addSubviews(welcomeLabel, usernameView, passwordView, stackView, btnNext)
        self.usernameView.addSubviews(emailLabel,txtUserName)
        self.passwordView.addSubviews(passwordLabel,txtPassword)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        imgHeader.topToSuperview(offset: 44, usingSafeArea: true)
        imgHeader.height(178)
        imgHeader.width(149)
        imgHeader.leadingToSuperview(offset: 120)
        
        rectangleView.edgesToSuperview(excluding: .top)
        rectangleView.topToBottom(of: imgHeader, offset: 24)
        
        welcomeLabel.height(36)
        welcomeLabel.top(to: rectangleView, offset: 64)
        welcomeLabel.leading(to: rectangleView, offset: 82)

        usernameView.height(74)
        usernameView.topToBottom(of: welcomeLabel, offset: 41)
        usernameView.leading(to: rectangleView, offset: 24)
        usernameView.trailing(to: rectangleView, offset: -24)
        
        emailLabel.top(to: usernameView, offset: 8)
        emailLabel.leading(to: usernameView, offset: 12)
        
        txtUserName.topToBottom(of: emailLabel, offset: 8)
        txtUserName.leading(to: emailLabel)
        txtUserName.bottom(to: usernameView, offset: -8)

        passwordView.height(74)
        passwordView.topToBottom(of: usernameView, offset: 24)
        passwordView.leading(to: usernameView)
        passwordView.trailing(to: usernameView)
        
        passwordLabel.top(to: passwordView, offset: 8)
        passwordLabel.leading(to: passwordView, offset: 12)
        
        txtPassword.topToBottom(of: passwordLabel, offset: 8)
        txtPassword.bottom(to: passwordView, offset: -8)
        txtPassword.leading(to: passwordLabel)
        
        btnNext.topToBottom(of: passwordView, offset: 48)
        btnNext.height(54)
        btnNext.leadingToSuperview(offset: 24)
        btnNext.trailingToSuperview(offset: 24)

        stackView.bottomToSuperview(offset: -21,usingSafeArea: true)
        stackView.centerXToSuperview()
        stackView.height(21)

       
    }
}

extension LoginVC: UITextFieldDelegate {
    
}





