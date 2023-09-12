//
//  HelpAndSupportVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 8.09.2023.
//

import SnapKit
import UIKit

class HelpAndSupportVC: UIViewController {
    let vm = HelpAndSupportVM()

    private lazy var retangle: CustomBackgroundRetangle = {
        let view = CustomBackgroundRetangle()
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        return button
    }()

    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "Help&Support"
        label.font = Font.poppins(fontType: 600, size: 32).font
        label.textColor = .white

        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 18
        layout.sectionInset = UIEdgeInsets(top: 10, left: 24, bottom: 0, right: 24)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(HelpAndSupportCVC.self, forCellWithReuseIdentifier: "CellID")
        cv.register(HelpAndSupportCVH.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderID")
        cv.backgroundColor = ColorEnum.viewColor.uiColor
        cv.showsVerticalScrollIndicator = false
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func setupView() {
        view.backgroundColor = ColorEnum.travioBackground.uiColor
        view.addSubviews(retangle, backButton, header)
        retangle.addSubview(collectionView)
        setupLayouts()
    }
    
    func setupLayouts() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(36)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(21.5)
            make.width.equalTo(24)
        }

        header.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(24)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(23)
        }

        retangle.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(54)
            make.leading.trailing.bottom.equalToSuperview()
        }
  
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension HelpAndSupportVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.faq.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as? HelpAndSupportCVC else { return UICollectionViewCell() }
        let arr = vm.faq[indexPath.row]
        cell.configure(model: arr)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return vm.sizeForItemAt(indexPath: indexPath, collectionViewWidth: collectionView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        vm.isCellExpanded[indexPath.row] = !vm.isCellExpanded[indexPath.row]
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderID", for: indexPath) as? HelpAndSupportCVH else { return UICollectionReusableView() }
            return header
        }
        return UICollectionReusableView()
    }
}
