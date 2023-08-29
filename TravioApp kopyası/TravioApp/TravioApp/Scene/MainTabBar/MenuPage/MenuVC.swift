//
//  MenuVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import SnapKit

class MenuVC: UIViewController {
    
    private lazy var header:UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = Font.poppins(fontType: 600, size: 32).font
        label.textColor = .white
        
        return label
    }()
    
    private lazy var retangle:CustomBackgroundRetangle = {
       let retangle = CustomBackgroundRetangle()
        
        return retangle
    }()
    
    
    private lazy var profileImage:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "bruceWills")
        img.layer.cornerRadius = 60
        return img
    }()

    private lazy var profileName:UILabel = {
       let label = UILabel()
        label.text = "Bruce Wills"
        label.font = Font.poppins(fontType: 600, size: 16).font
        label.textColor = .black
        return label
    }()
    
    private lazy var editProfileButton:UIButton = {
       let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = Font.poppins(fontType: 400, size: 12).font
        button.setTitleColor(ColorEnum.travioBackground.uiColor, for: .normal)
        
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 18
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        
        cv.register(MenuCVC.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
    
    
    override func viewDidLoad() {
    setupView()
    }
    
    func setupView(){
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        self.view.addSubviews(header,retangle)
        retangle.addSubviews(profileImage,profileName,editProfileButton,collectionView)
        
        setupLayouts()
    }
    
    func setupLayouts() {
        
        header.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(23)
            make.leading.equalToSuperview().offset(20)
        }
        
        retangle.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(54)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
        }
        
        profileName.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalTo(profileName.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(editProfileButton.snp.bottom).offset(21)
            make.leading.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().offset(-13)
            make.bottom.equalToSuperview()
        }
    }
}


extension MenuVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 358, height: 54)
        }
    
    
}
