//
//  SecuritySettingsVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 29.08.2023.
//

import UIKit
import SnapKit
import Alamofire
import AVFoundation
import Photos
import CoreLocation

final class SecuritySettingsVC: UIViewController {
    //MARK: - Variables
    let vm = SecuritySettingsVM()
    //MARK: - Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView:UIView = {
        let view = UIView()
        return view
    }()
    
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
        label.text = "Security Settings"
        label.font = Font.poppins(fontType: 600, size: 32).font
        label.textColor = .white
        return label
    }()
    
    private lazy var changePasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Change Password"
        label.font = Font.poppins(fontType: 600, size: 16).font
        label.textColor = ColorEnum.travioBackground.uiColor
        return label
    }()
    
    private lazy var newPassword:CustomTF = {
        let tf = CustomTF()
        tf.labelText = "New Password"
        tf.placeholderName = ""
        tf.isSecure = true
        return tf
    }()
    
    private lazy var newPasswordConfirm:CustomTF = {
        let tf = CustomTF()
        tf.labelText = "New Password Confirm"
        tf.placeholderName = ""
        tf.isSecure = true
        return tf
    }()
    
    private lazy var privacyLabel: UILabel = {
        let label = UILabel()
        label.text = "Privacy"
        label.font = Font.poppins(fontType: 600, size: 16).font
        label.textColor = ColorEnum.travioBackground.uiColor
        return label
    }()
    
    private lazy var camera: CustomPrivacyView = {
        let view = CustomPrivacyView()
        view.labelText = "Camera"
        view.switchComponent.addTarget(self, action: #selector(cameraSwitch), for: .valueChanged)
        return view
    }()
    
    private lazy var photoLibrary: CustomPrivacyView = {
        let view = CustomPrivacyView()
        view.labelText = "Photo Library"
        view.switchComponent.addTarget(self, action: #selector(photoLibrarySwitch), for: .valueChanged)
        return view
    }()
    
    private lazy var location: CustomPrivacyView = {
        let view = CustomPrivacyView()
        view.labelText = "Location"
        view.switchComponent.addTarget(self, action: #selector(locationSwitch), for: .valueChanged)
        return view
    }()
    
    private lazy var button: CustomButton = {
        let button = CustomButton()
        button.labelText = "Save"
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSettings()
        NotificationCenter.default.addObserver(self, selector: #selector(updateSettings), name: Notification.Name("appDidBecomeActive"), object: nil)
        setupView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    //MARK: - Functions
    @objc func updateSettings() {
        updateCameraSwitchStates()
        updateLocationSwitchState()
        updatePhotoLibrarySwitchState()
    }
    
    @objc func cameraSwitch() {
        openAppSettings()
    }
    
    @objc func photoLibrarySwitch() {
        openAppSettings()
    }
    
    @objc func locationSwitch() {
        openAppSettings()
    }
    
    
    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func updateLocationSwitchState() {
        let locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        switch locationAuthorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            location.switchComponent.isOn = true
        case .denied, .restricted, .notDetermined:
            location.switchComponent.isOn  = false
        @unknown default:
            location.switchComponent.isOn  = false
        }
    }
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                self.openAppSettings()
            } else {
            }
        }
    }
    
    private func updateCameraSwitchStates() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthorizationStatus {
        case .authorized:
            camera.switchChanged = true
        case .denied, .restricted, .notDetermined:
            camera.switchChanged = false
        @unknown default:
            camera.switchChanged = true
        }
    }
    
    private func updatePhotoLibrarySwitchState() {
        let photoLibraryAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoLibraryAuthorizationStatus {
        case .authorized:
            photoLibrary.switchComponent.isOn = true
        case .denied, .restricted, .notDetermined:
            photoLibrary.switchComponent.isOn = false
        case .limited:
            photoLibrary.switchComponent.isOn = true
        @unknown default:
            photoLibrary.switchComponent.isOn = false
        }
    }
    
    @objc func saveButtonTapped() {
        guard let password = newPassword.txtField.text else {return}
        guard let passwordConfirm = newPasswordConfirm.txtField.text else {return}
        
        if password == passwordConfirm {
            if password.count == 0 {
                
            } else if password.count < 6 {
                showAlert(title: "Uyarı", message: "Şifreniz en az 6 eleman içermelidir")
                
            } else if password.count > 12 {
                showAlert(title: "Uyarı", message: "Şifreniz en fazla 12 eleman içermelidir")
            } else {
                let params: Parameters = ["new_password": password]
                self.vm.changePassword(params: params) { errorMessage in
                    if let errorMessage = errorMessage {
                        self.showAlert(title: "Hata!", message: errorMessage)
                    }
                    
                }
                
                showAlert(title: "Başarılı", message: """
                                                                Şifreniz başarıyla değiştirildi
                                                                Yeni Şifre
                                                                ** \(password) **
                                                                """)
            }
            
        } else {
            showAlert(title: "Uyarı", message: "Şifreler eşleşmiyor")
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView(){
        navigationController?.navigationBar.isHidden = true
        
        view.addSubviews(retangle,backButton,header)
        scrollView.addSubview(contentView)
        retangle.addSubviews(scrollView)
        
        view.backgroundColor = ColorEnum.travioBackground.uiColor
        contentView.addSubviews(changePasswordLabel,newPassword,newPasswordConfirm,privacyLabel,camera,photoLibrary,location,button)
        setupLayouts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: contentView.frame.width, height: contentView.frame.height)
    }
    
    private func setupLayouts() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(button.snp.bottom).offset(50)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.bottom.equalTo(location.snp.bottom).offset(20)
        }
        
        retangle.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(125)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(21)
            make.width.equalTo(24)
        }
        
        header.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(19)
            make.leading.equalTo(backButton.snp.trailing).offset(24)
        }
        
        changePasswordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.leading.equalToSuperview().offset(24)
        }
        
        newPassword.snp.makeConstraints { make in
            make.top.equalTo(changePasswordLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(74)
        }
        
        newPasswordConfirm.snp.makeConstraints { make in
            make.top.equalTo(newPassword.snp.bottom).offset(8.51)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(74)
        }
        
        privacyLabel.snp.makeConstraints { make in
            make.top.equalTo(newPasswordConfirm.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        
        camera.snp.makeConstraints { make in
            make.top.equalTo(privacyLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(74)
        }
        
        photoLibrary.snp.makeConstraints { make in
            make.top.equalTo(camera.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(74)
        }
        
        location.snp.makeConstraints { make in
            make.top.equalTo(photoLibrary.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(74)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(location.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(54)
        }
    }
}

