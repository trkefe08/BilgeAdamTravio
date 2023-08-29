//
//  SignUpVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import TinyConstraints

class SignUpVC: UIViewController {
    
    private lazy var labelSignUp: UILabel = {
        let lbl = UILabel()
        lbl.text = "Sign Up"
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-Bold", size: 36)
        return lbl
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        if let image = UIImage(named: "Vector") {
            btn.setImage(image, for: .normal)
        }
       
        return btn
    }()
    
    private lazy var rectangleView: UIView = {
        let v = UIView()
        let selectedColor = ColorEnum.viewColor
        if let colorValue = selectedColor.uiColor {
            v.backgroundColor = colorValue
        }
        return v
    }()
    
    private lazy var stackViewTF:UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.spacing = 24
        sv.axis = .vertical
        return sv
        
    }()
    
    private lazy var usernameView: UIView = {
        let v = UIView()
        let selectedColor = ColorEnum.tfBackground
        if let colorValue = selectedColor.uiColor {
            v.backgroundColor = colorValue
        }
        return v
    }()
    
    private lazy var usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Username"
        let selectedColor = ColorEnum.fontColor
        if let colorValue = selectedColor.uiColor {
            lbl.textColor = colorValue
        }
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 14)
        return lbl
    }()
    
    private lazy var txtUserName: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "bilge_adam"
        tf.delegate = self
        return tf
    }()
    
    private lazy var emailView: UIView = {
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
    
    private lazy var txtEmail: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "developer@bilgeadam.com"
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
    
    private lazy var txtPassword: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "************"
        tf.delegate = self
        return tf
    }()
    
    private lazy var confirmView: UIView = {
        let v = UIView()
        let selectedColor = ColorEnum.tfBackground
        if let colorValue = selectedColor.uiColor {
            v.backgroundColor = colorValue
        }
        return v
    }()
    
    private lazy var confirmLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Password Confirm"
        let selectedColor = ColorEnum.fontColor
        if let colorValue = selectedColor.uiColor {
            lbl.textColor = colorValue
        }
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 14)
        return lbl
    }()
    
    private lazy var txtConfirm: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "************"
        tf.delegate = self
        return tf
    }()
    
    private lazy var btnSignUp:UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
        let selectedColor = ColorEnum.btnDefaultBackground
        if let colorValue = selectedColor.uiColor {
            button.backgroundColor = colorValue
        }
        button.addTarget(self, action: #selector(btnSignUpTapped), for: .touchUpInside)
        return button
    }()

    let viewModel = SignUpViewModel()
    
    
    override func viewDidLayoutSubviews() {
        rectangleView.roundCorners(corners: .topLeft, radius: 80)
        btnSignUp.roundCorners(corners: [.topLeft, .bottomLeft, .topRight], radius: 12)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        usernameView.roundCorners(corners: [.topLeft, .bottomLeft, .topRight], radius: 16)
        passwordView.roundCorners(corners: [.topLeft, .bottomLeft, .topRight], radius: 16)
        emailView.roundCorners(corners: [.topLeft, .bottomLeft, .topRight], radius: 16)
        confirmView.roundCorners(corners: [.topLeft, .bottomLeft, .topRight], radius: 16)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        
        self.navigationController?.navigationBar.isHidden = true
        let selectedColor = ColorEnum.travioBackground
        if let colorValue = selectedColor.uiColor {
            view.backgroundColor = colorValue
        }
        self.view.addSubviews(backButton,labelSignUp,rectangleView)
        self.rectangleView.addSubviews(stackViewTF, btnSignUp)
        stackViewTF.addArrangedSubviews(usernameView, emailView, passwordView, confirmView)
        self.usernameView.addSubviews(usernameLabel, txtUserName)
        self.emailView.addSubviews(emailLabel, txtEmail)
        self.passwordView.addSubviews(passwordLabel, txtPassword)
        self.confirmView.addSubviews(confirmLabel, txtConfirm)
        setupLayout()
    }
    
    func setupLayout() {
        labelSignUp.topToSuperview(offset: 16, usingSafeArea: true)
        labelSignUp.leadingToSuperview(offset: 120)
        
        backButton.topToSuperview(offset:32, usingSafeArea: true)
        backButton.leadingToSuperview(offset:24)
        backButton.height(21.39)
        
        rectangleView.edgesToSuperview(excluding: .top)
        rectangleView.topToBottom(of: labelSignUp, offset: 56)
        
        stackViewTF.top(to: rectangleView, offset: 72)
        stackViewTF.leadingToSuperview(offset: 24)
        stackViewTF.trailingToSuperview(offset: 24)

        usernameView.height(74)

        usernameLabel.top(to: usernameView, offset: 8)
        usernameLabel.leading(to: usernameView, offset: 12)
        txtUserName.topToBottom(of: usernameLabel, offset: 8)
        txtUserName.leading(to: usernameLabel)
        txtUserName.bottom(to: usernameView, offset: -8)
        
        emailLabel.top(to: emailView, offset: 8)
        emailLabel.leading(to: emailView, offset: 12)
        txtEmail.topToBottom(of: emailLabel, offset: 8)
        txtEmail.leading(to: emailLabel)
        txtEmail.bottom(to: emailView, offset: -8)
        
        passwordLabel.top(to: passwordView, offset: 8)
        passwordLabel.leading(to: passwordView, offset: 12)
        txtPassword.topToBottom(of: passwordLabel, offset: 8)
        txtPassword.leading(to: passwordLabel)
        txtPassword.bottom(to: passwordView, offset: -8)
        
        confirmLabel.top(to: confirmView, offset: 8)
        confirmLabel.leading(to: confirmView, offset: 12)
        txtConfirm.topToBottom(of: confirmLabel, offset: 8)
        txtConfirm.leading(to: confirmLabel)
        txtConfirm.bottom(to: confirmView, offset: -8)
        
        btnSignUp.height(54)
        btnSignUp.bottomToSuperview(offset: -23, usingSafeArea: true)
        btnSignUp.leadingToSuperview(offset: 24)
        btnSignUp.trailingToSuperview(offset: 24)
    }
    
    @objc func btnSignUpTapped() {
        
    }
    

}

extension SignUpVC: UITextFieldDelegate {
    
}



