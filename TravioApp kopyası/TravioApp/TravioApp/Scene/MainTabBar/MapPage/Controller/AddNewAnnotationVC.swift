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

class AddNewAnnotationVC: UIViewController {
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
        txt.text = "aaaaaaaaaaaaaaa"
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
    var images: [Data?] = []
    var cityName: String?
    var countryName: String?
    var latitude: Double?
    var longitude: Double?
    var selectedImages: [IndexPath: Data] = [:]
    var viewModel = AddNewAnnotationViewModel()
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
        rectangleView.centerXToSuperview()
        rectangleView.topToSuperview(offset: 16)
        rectangleView.height(8)
        rectangleView.width(70)
        
        placeNameView.topToBottom(of: rectangleView, offset: 22)
        placeNameView.leadingToSuperview(offset: 24)
        placeNameView.trailingToSuperview(offset: 24)
        placeNameView.height(74)
        
        placeNameLabel.topToSuperview(offset: 8)
        placeNameLabel.leadingToSuperview(offset: 16)
        txtPlaceName.topToBottom(of: placeNameLabel, offset: 8)
        txtPlaceName.leading(to: placeNameLabel)
        txtPlaceName.bottomToSuperview(offset: -8)
        
        visitDescView.topToBottom(of: placeNameView, offset: 16)
        visitDescView.leading(to: placeNameView)
        visitDescView.trailing(to: placeNameView)
        visitDescView.height(215)
        
        
        visitDescLabel.topToSuperview(offset: 8)
        visitDescLabel.leadingToSuperview(offset: 16)
        visitDescTxtView.topToBottom(of: visitDescLabel, offset: 8)
        visitDescTxtView.leading(to: visitDescLabel)
        visitDescTxtView.trailingToSuperview(offset: 16)
        visitDescTxtView.bottomToSuperview(offset: -16)
        
        
        countryCityView.topToBottom(of: visitDescView, offset: 16)
        countryCityView.leading(to: placeNameView)
        countryCityView.trailing(to: placeNameView)
        countryCityView.height(74)
        
        countryCityLabel.topToSuperview(offset: 8)
        countryCityLabel.leadingToSuperview(offset: 16)
        locationLabel.topToBottom(of: countryCityLabel, offset: 8)
        locationLabel.leading(to: countryCityLabel)
        
        collectionView.topToBottom(of: countryCityView, offset: 16)
        collectionView.leadingToSuperview(offset: 24)
        collectionView.trailingToSuperview()
        collectionView.height(215)
        
        addPlaceButton.topToBottom(of: collectionView, offset: 16)
        addPlaceButton.leadingToSuperview(offset: 24)
        addPlaceButton.trailingToSuperview(offset: 24)
        addPlaceButton.height(54)
        addPlaceButton.bottomToSuperview(offset: -24, usingSafeArea: true)
        
    }
    
    @objc func addPlaceButtonTapped() {
        viewModel.upload(image: images) { urls in
            guard let imageUrls = urls else {
                print("Upload failed or URLs are empty.")
                return
            }
            self.postPlaceMethod(imageUrls: imageUrls)
        }
    }
    func postPlaceMethod(imageUrls: [String?]) {
        guard let place = locationLabel.text,
              let title = txtPlaceName.text,
              let desc = visitDescTxtView.text,
              let lat = latitude,
              let long = longitude else { return }
        if let image = imageUrls.first {
            guard let image = image else { return }
            viewModel.postNewPlace(params: ["place": place, "title": title, "description": desc, "cover_image_url": image, "latitude": lat, "longitude": long]) { placeId in
                guard let placeId = placeId else {
                    print("Failed to post new place or place ID is empty.")
                    return
                }
                self.postGalleryMethod(imageUrls: imageUrls, placeId: placeId)
            }
        }
    }
    
    func postGalleryMethod(imageUrls: [String?], placeId: String ) {
        for imageUrl in imageUrls {
            guard let imageUrl = imageUrl else { return }
            self.viewModel.postGallery(params: ["place_id": placeId, "image_url": imageUrl])
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
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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
    
}


