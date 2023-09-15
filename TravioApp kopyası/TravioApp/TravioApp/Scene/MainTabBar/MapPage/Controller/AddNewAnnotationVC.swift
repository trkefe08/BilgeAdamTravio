//
//  AddNewAnnotationVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import TinyConstraints
import UniformTypeIdentifiers
import CoreLocation
import MapKit

final class AddNewAnnotationVC: UIViewController {
    //MARK: - Views
    private lazy var rectangleView: UIView = {
        let v = UIView()
        v.backgroundColor = ColorEnum.addNewAnnotationVcRectangleColor.uiColor
        return v
    }()
    
    private lazy var placeNameView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var placeNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Place Name"
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        return lbl
    }()
    
    private lazy var txtPlaceName: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Please write a place name"
        tf.font = UIFont(name: "Poppins-Regular", size: 12)
        tf.delegate = self
        return tf
    }()
    
    private lazy var visitDescView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var visitDescLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Visit Description"
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        return lbl
    }()
    
    private lazy var visitDescTxtView: UITextView = {
        let txt = UITextView()
        txt.font = UIFont(name: "Poppins-Regular", size: 12)
        txt.textColor = .black
        return txt
    }()
    
    private lazy var countryCityView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var countryCityLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Country, City"
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        return lbl
    }()
    
    private lazy var locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-Regular", size: 12)
        return lbl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(AddPlaceCollectionViewCell.self, forCellWithReuseIdentifier: "AddPlaceCollectionViewCell")
        cv.backgroundColor = .clear
        return cv
    }()
    
    private lazy var addPhotoImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "addphoto")
        return img
    }()
    
    private lazy var addPlaceButton:UIButton = {
        let button = UIButton()
        button.setTitle("Add Place", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        button.backgroundColor = ColorEnum.travioBackground.uiColor
        button.addTarget(self, action: #selector(addPlaceButtonTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - Variables
    private var images: [Data?] = []
    var cityName: String?
    var countryName: String?
    var latitude: Double?
    var longitude: Double?
    private var selectedImages: [IndexPath: Data] = [:]
    private var viewModel = AddNewAnnotationViewModel()
    weak var delegate: AddAnnotationDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        collectionView.roundCornersWithShadow([.topLeft, .topRight, .bottomLeft], radius: 16)
    }
    
    override func viewDidLayoutSubviews() {
        self.view.roundCorners(corners: [.topLeft, .topRight], radius: 24)
        rectangleView.roundCorners(corners: .allCorners, radius: 6)
        placeNameView.roundCornersWithShadow([.topLeft, .topRight, .bottomLeft], radius: 16)
        visitDescView.roundCornersWithShadow([.topLeft, .topRight, .bottomLeft], radius: 16)
        countryCityView.roundCornersWithShadow( [.topLeft, .topRight, .bottomLeft], radius: 16)
        addPlaceButton.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 12)
        
    }
    //MARK: - Functions
    private func setupViews() {
        self.view.backgroundColor = ColorEnum.viewColor.uiColor
        self.view.addSubviews(rectangleView, placeNameView, visitDescView, countryCityView, collectionView, addPlaceButton)
        self.placeNameView.addSubviews(placeNameLabel, txtPlaceName)
        self.visitDescView.addSubviews(visitDescLabel, visitDescTxtView)
        self.countryCityView.addSubviews(countryCityLabel, locationLabel)
        self.collectionView.addSubviews(addPhotoImage)
        setupLayout()
        guard let cityName = cityName, let countryName = countryName else { return }
        locationLabel.text = countryName + "," + cityName
    }
    
    private func setupLayout() {
        let screenHeight = UIScreen.main.bounds.height
        rectangleView.centerXToSuperview()
        rectangleView.topToSuperview(offset: screenHeight * 0.013 )
        rectangleView.height(8)
        rectangleView.width(70)
        
        placeNameView.topToBottom(of: rectangleView, offset: screenHeight * 0.013 * 1.5)
        placeNameView.leadingToSuperview(offset: 24)
        placeNameView.trailingToSuperview(offset: 24)
        placeNameView.height(screenHeight * 0.087)
        
        placeNameLabel.topToSuperview(offset: 8)
        placeNameLabel.leadingToSuperview(offset: 16)
        txtPlaceName.topToBottom(of: placeNameLabel, offset: 8)
        txtPlaceName.leading(to: placeNameLabel)
        txtPlaceName.bottomToSuperview(offset: -8)
        
        visitDescView.topToBottom(of: placeNameView, offset: screenHeight * 0.013)
        visitDescView.leading(to: placeNameView)
        visitDescView.trailing(to: placeNameView)
        visitDescView.height(screenHeight * 0.25)
        
        visitDescLabel.topToSuperview(offset: 8)
        visitDescLabel.leadingToSuperview(offset: 16)
        visitDescTxtView.topToBottom(of: visitDescLabel, offset: 8)
        visitDescTxtView.leading(to: visitDescLabel)
        visitDescTxtView.trailingToSuperview(offset: 16)
        visitDescTxtView.bottomToSuperview(offset: -16)
        
        countryCityView.topToBottom(of: visitDescView, offset: screenHeight * 0.013)
        countryCityView.leading(to: placeNameView)
        countryCityView.trailing(to: placeNameView)
        countryCityView.height(screenHeight * 0.087)
        
        countryCityLabel.topToSuperview(offset: 8)
        countryCityLabel.leadingToSuperview(offset: 16)
        locationLabel.topToBottom(of: countryCityLabel, offset: 8)
        locationLabel.leading(to: countryCityLabel)
        
        collectionView.topToBottom(of: countryCityView, offset: screenHeight * 0.013)
        collectionView.leadingToSuperview(offset: 24)
        collectionView.trailingToSuperview()
        collectionView.height(screenHeight * 0.25)
        
        addPlaceButton.topToBottom(of: collectionView, offset: screenHeight * 0.013)
        addPlaceButton.leadingToSuperview(offset: 24)
        addPlaceButton.trailingToSuperview(offset: 24)
        addPlaceButton.height(screenHeight * 0.063)
        addPlaceButton.bottomToSuperview(offset: -24, usingSafeArea: true)
        
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func requiredImagesControl() {
        guard !images.isEmpty else {
            showAlert(message: "Lütfen Fotoğraf Ekleyiniz!")
            return
        }
    }
    
    @objc func addPlaceButtonTapped() {
        requiredImagesControl()
        viewModel.upload(image: images) { urls in
            if urls == nil {
                self.showAlert(title: "Hata", message: "URL Dizini Boş")
            }
            guard let imageUrls = urls else {
                return
            }
            self.postPlaceMethod(imageUrls: imageUrls)
        }
    }
    
    private func postPlaceMethod(imageUrls: [String?]) {
        guard let place = locationLabel.text, !place.isEmpty,
              let title = txtPlaceName.text, !title.isEmpty,
              let desc = visitDescTxtView.text, !desc.isEmpty,
              let lat = latitude,
              let long = longitude else {
            showAlert(message: "Lütfen Tüm Alanları Doldurunuz!")
            return }
        if let image = imageUrls.first {
            guard let image = image else { return }
            viewModel.postNewPlace(params: ["place": place, "title": title, "description": desc, "cover_image_url": image, "latitude": lat, "longitude": long]) { placeId in
                if placeId == nil {
                    self.showAlert(title: "Hata!", message: "Post New Place İşlemi Tamamlanamadı. ")
                }
                guard let placeId = placeId else {
                    return
                }
                self.postGalleryMethod(imageUrls: imageUrls, placeId: placeId)
            }
        }
    }
    
    private func postGalleryMethod(imageUrls: [String?], placeId: String ) {
        for imageUrl in imageUrls {
            guard let imageUrl = imageUrl else { return }
            self.viewModel.postGallery(params: ["place_id": placeId, "image_url": imageUrl]) { errorMessage in
                if let errorMessage = errorMessage {
                    self.showAlert(title: "Hata!", message: errorMessage)
                }
                
            }
        }
        self.delegate?.didAddAnnotation()
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - CollectionView Extension
extension AddNewAnnotationVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width - 97 , height: 215)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        alertController()
    }
    
    private func alertController() {
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
}

extension AddNewAnnotationVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPlaceCollectionViewCell", for: indexPath) as? AddPlaceCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    
}
//MARK: - UIImagePicker Extension
extension AddNewAnnotationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                selectedImages[indexPath] = selectedImage.jpegData(compressionQuality: 0.5)
                images.append(selectedImages[indexPath])
                if let cell = collectionView.cellForItem(at: indexPath) as? AddPlaceCollectionViewCell {
                    cell.placeImage.image = selectedImage
                    cell.addPhotoImage.isHidden = true
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITextField Extension
extension AddNewAnnotationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty == true {
            showAlert(message: "Lütfen Tüm Alanları Doldurunuz!")
            return false
        }
        return true
    }
}
