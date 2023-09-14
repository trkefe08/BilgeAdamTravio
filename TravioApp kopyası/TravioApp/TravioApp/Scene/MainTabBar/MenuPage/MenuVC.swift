//
//  MenuVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//
import SnapKit
import UIKit
import SDWebImage

final class MenuVC: UIViewController {
    //MARK: - Variables
    var viewModel = MenuViewModel()
    //MARK: - Views
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = Font.poppins(fontType: 600, size: 32).font
        label.textColor = .white
        
        return label
    }()
    
    private lazy var retangle: CustomBackgroundRetangle = {
        let retangle = CustomBackgroundRetangle()
        
        return retangle
    }()
    
    private lazy var profileImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "person.circle.fill")
        img.layer.cornerRadius = 60
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var profileName: UILabel = {
        let label = UILabel()
        label.text = "Bruce Wills"
        label.font = Font.poppins(fontType: 600, size: 16).font
        label.textColor = .black
        return label
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = Font.poppins(fontType: 400, size: 12).font
        button.setTitleColor(ColorEnum.travioBackground.uiColor, for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.register(MenuCVC.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        setupView()
        viewModel.getProfile {
            self.configure()
        }
        
    }
    //MARK: - Functions
    @objc func editButtonTapped() {
        let vc = EditProfile()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private func configure() {
        guard let data = viewModel.data else {return}
        profileName.text = data.fullName
        profileImage.sd_setImage(with:URL(string: data.ppUrl))
    }
    
    private func setupView() {
        view.backgroundColor = ColorEnum.travioBackground.uiColor
        view.addSubviews(header, retangle)
        retangle.addSubviews(profileImage, profileName, editProfileButton, collectionView)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
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
            make.top.equalTo(editProfileButton.snp.bottom).offset(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
//MARK: - UICollectionView Extension
extension MenuVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.countCalc()
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MenuCVC else { return UICollectionViewCell() }
        
        let array = viewModel.settingsCVArray
        
        cell.configure(item: array[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 54)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = SecuritySettingsVC()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            break
        case 2:
            let vc = MyAddedPlacesVC()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = HelpAndSupportVC()
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = AboutUsVC()
            navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = TermOfUseVC()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 9, left: 16, bottom: 0, right: 16)
    }
}
//MARK: - Protocol
extension MenuVC: ProfileUpdateDelegate {
    func didUpdateProfile() {
        viewModel.getProfile {
            self.configure()
        }
    }
}
