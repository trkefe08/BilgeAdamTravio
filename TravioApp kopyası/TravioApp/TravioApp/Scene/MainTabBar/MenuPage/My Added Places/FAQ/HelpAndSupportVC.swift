//
//  HelpAndSupportVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 8.09.2023.
//

import UIKit
import SnapKit

class HelpAndSupportVC: UIViewController {

    private lazy var retangle:CustomBackgroundRetangle = {
        let view = CustomBackgroundRetangle()
        
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
        label.text = "Help&Support"
        label.font = Font.poppins(fontType: 600, size: 32).font
        label.textColor = .white

        return label
    }()
    
    private lazy var label:UILabel = {
        let lbl = UILabel()
        lbl.text = "FAQ"
        lbl.font = Font.poppins(fontType: 600, size: 24).font
        lbl.textColor = ColorEnum.travioBackground.uiColor
        return lbl
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 18
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(HelpAndSupportCVC.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView(){
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        
        view.addSubviews(retangle,backButton,header)
        retangle.addSubviews(label,collectionView)
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
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.leading.equalToSuperview().offset(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(20)
            
        }
        
        
    }
    
}

extension HelpAndSupportVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HelpAndSupportCVC else { return UICollectionViewCell()}
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 100)  // İstediğiniz boyutu burada ayarlayabilirsiniz.
        }
    
}
