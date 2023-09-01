////
////  MyAddedPlacesVC.swift
////  TravioApp
////
////  Created by Doğucan Durgun on 1.09.2023.
////
//
//import UIKit
//import SnapKit
//
//class MyAddedPlacesVC: UIViewController {
//
//    private lazy var retangle:CustomBackgroundRetangle = {
//       let retangle = CustomBackgroundRetangle()
//       return retangle
//    }()
//
//    private lazy var backButton:UIButton = {
//       let button = UIButton()
//        button.setImage(UIImage(named: "Vector"), for: .normal)
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//
//        return button
//    }()
//
//    private lazy var header:UILabel = {
//       let label = UILabel()
//        label.text = "My Added Places"
//        label.font = Font.poppins(fontType: 600, size: 32).font
//        label.textColor = .white
//
//        return label
//    }()
//
//    private lazy var sortFilter:UIButton = {
//        let img = UIButton()
//        img.setImage(#imageLiteral(resourceName: "myAddedPlace_aToZ"), for: .normal)
//
//        return img
//    }()
//
////    private lazy var collectionView: UICollectionView = {
////        let layout = UICollectionViewFlowLayout()
////        layout.scrollDirection = .horizontal
////        layout.minimumLineSpacing = 18
////
////        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
////        cv.delegate = self
////        cv.dataSource = self
////
////        return cv
////    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupView()
//        view.backgroundColor = ColorEnum.travioBackground.uiColor
//    }
//
//    @objc func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//
//    }
//
//
//    func setupView(){
//
//        view.addSubviews(retangle,backButton,header)
//        retangle.addSubviews(sortFilter)
//
//
//        setupLayouts()
//    }
//
//    func setupLayouts() {
//
//
//
//        backButton.snp.makeConstraints { make in
//            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(36)
//            make.leading.equalToSuperview().offset(20)
//            make.height.equalTo(21.5)
//            make.width.equalTo(24)
//        }
//
//        header.snp.makeConstraints { make in
//            make.leading.equalTo(backButton.snp.trailing).offset(24)
//            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(23)
//        }
//
//        retangle.snp.makeConstraints { make in
//            make.top.equalTo(header.snp.bottom).offset(54)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
//
//        sortFilter.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(24)
//            make.trailing.equalToSuperview().offset(-23)
//            make.height.width.equalTo(22)
//        }
//    }
//}
