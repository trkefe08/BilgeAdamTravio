//
//  EditProfile.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 31.08.2023.
//

import UIKit
import SnapKit
import Alamofire
import MobileCoreServices

protocol ProfileUpdateDelegate: AnyObject {
    func didUpdateProfile()
}

class EditProfileVC: UIViewController {
    
    let vm = EditProfileViewModel()
    weak var delegate: ProfileUpdateDelegate?
    
    private lazy var header:UILabel = {
        let label = UILabel()
        label.text = "Edit Profile"
        label.font = Font.poppins(fontType: 600, size: 32).font
        label.textColor = .white
        
        return label
    }()
    
    private lazy var rectangle:CustomBackgroundRectangle = {
       let retangle = CustomBackgroundRectangle()
        
       return retangle
    }()
    
    private lazy var profileImage:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(systemName: "person.circle.fill")
        img.layer.cornerRadius = 60
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    private lazy var backButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var changePhotoButton:UIButton = {
       let button = UIButton()
        button.setTitle("Change Photo", for: .normal)
        button.titleLabel?.font = Font.poppins(fontType: 400, size: 12).font
        button.setTitleColor(ColorEnum.travioBackground.uiColor, for: .normal)
        
        button.addTarget(self, action: #selector(changePhotoButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var profileName:UILabel = {
       let label = UILabel()
        label.text = "Bruce Wills"
        label.font = Font.poppins(fontType: 600, size: 24).font
        label.textColor = .black
        
        return label
    }()
    
    private lazy var createdDateView:CustomEditProfileView = {
        let view = CustomEditProfileView()
        view.newImage = #imageLiteral(resourceName: "editProfile_date")
        view.labelText = "Date"
        
        return view
    }()
    
    private lazy var rolView:CustomEditProfileView = {
        let view = CustomEditProfileView()
        view.newImage = #imageLiteral(resourceName: "editProfile_rol")
        view.labelText = "Role"
        
        return view
    }()
    
    private lazy var fullNameView: CustomTF = {
        let view = CustomTF()
        view.labelText = "Full Name"
        view.placeholderName = "bilge_adam"
        
        return view
    }()
    
    private lazy var emailView: CustomTF = {
        let view = CustomTF()
        view.labelText = "Email"
        view.placeholderName = "bilge_adam"
        
        return view
    }()
    
    private lazy var saveButton:CustomButton = {
       let button = CustomButton()
       button.labelText = "Save"
       button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getProfile()
        setupView()
    }
    
    func getProfile(){
        vm.getProfile {
            self.vm.oldURL = self.vm.data?.ppUrl
            self.configure()
        }
    }
    
    func configure() {
        guard let data = vm.data else {return}
        
        profileImage.sd_setImage(with: URL(string:data.ppUrl))
        profileName.text = data.fullName
        rolView.labelText = data.role
        fullNameView.txtField.text = data.fullName
        emailView.txtField.text = data.email
        
        if let date = data.createdAt.dateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MM yyyy"
            createdDateView.labelText = formatter.string(from: date)
        } else {
            createdDateView.labelText = "Unknown Date"
        }
    }

 
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
 
    @objc func saveButtonTapped() {
        guard let fullName = fullNameView.txtField.text else {return}
        guard let mail = emailView.txtField.text else {return}
        let url = vm.images?.urls?.first ?? vm.oldURL
        
        let params: Parameters = [
            "full_name": fullName,
            "email": mail,
            "pp_url": url]
        
        DispatchQueue.main.async {
            self.vm.editProfile(params: params){
            }
        }
        dismiss(animated: true) {
            self.delegate?.didUpdateProfile()
        }
    }
 
    func setupView(){
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        navigationController?.navigationBar.isHidden = true
        
        view.addSubviews(header,rectangle,backButton)
        rectangle.addSubviews(profileImage,createdDateView,changePhotoButton,profileName,rolView,fullNameView,emailView,saveButton)
        
        setupLayouts()
    }
    
    func setupLayouts() {
        header.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(23)
            make.leading.equalTo(backButton.snp.trailing).offset(24)
        }
        
        rectangle.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(54)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(36)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(21)
            make.width.equalTo(24)
        }
        
        changePhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom).offset(7)
            make.height.equalTo(18)
        }
        
        profileName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(changePhotoButton.snp.bottom).offset(7)
            make.height.equalTo(36)
        }
        
        createdDateView.snp.makeConstraints { make in
            make.top.equalTo(profileName.snp.bottom).offset(21)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo((UIScreen.main.bounds.width-64)/2)
            make.height.equalTo(52)
        }
        
        rolView.snp.makeConstraints { make in
            make.top.equalTo(profileName.snp.bottom).offset(21)
            make.width.equalTo((UIScreen.main.bounds.width-64)/2)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }
        
        fullNameView.snp.makeConstraints { make in
            make.top.equalTo(createdDateView.snp.bottom).offset(19)
            make.height.equalTo(74)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(fullNameView.snp.bottom).offset(16)
            make.height.equalTo(74)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
      
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(101)
            make.height.equalTo(51)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}

extension EditProfileVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @objc func changePhotoButtonTapped() {
        let alertController = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)

        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                self?.present(imagePicker, animated: true)
            }
        }

        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self?.present(imagePicker, animated: true)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }

        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImage.image = selectedImage
           let imageData = selectedImage.jpegData(compressionQuality: 0.5)
            vm.uploadImage(image: [imageData] ) {
            }
        }
        dismiss(animated: true)
    }

}

