//
//  MyAddedPlacesVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 1.09.2023.
//

import UIKit
import SnapKit
import SDWebImage

class MyAddedPlacesVC: UIViewController {
    var viewModel = MyAddedPlacesVM()
    var isButtonActive = false

    private lazy var retangle:CustomBackgroundRectangle = {
       let retangle = CustomBackgroundRectangle()
       return retangle
    }()

    private lazy var backButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        return button
    }()

    private lazy var header:UILabel = {
       let label = UILabel()
        label.text = "My Added Places"
        label.font = Font.poppins(fontType: 600, size: 32).font
        label.textColor = .white

        return label
    }()

    private lazy var sortFilter:UIButton = {
        let img = UIButton()
        img.setImage(UIImage(named: "myAddedPlace_AtoZ"), for: .normal)
        img.addTarget(self, action: #selector(sortFilterTapped), for: .touchUpInside)
        return img
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 18
        layout.sectionInset = UIEdgeInsets(top: 10 , left: 24, bottom: 0, right: 24)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(MyAddedPlaceCVC.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = ColorEnum.viewColor.uiColor
        cv.showsVerticalScrollIndicator = false
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        view.backgroundColor = ColorEnum.travioBackground.uiColor
        
        viewModel.getAllPlacesForUser {
            self.collectionView.reloadData()
        }
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sortFilterTapped() {
        isButtonActive.toggle()
               
               if isButtonActive {
                   sortFilter.setImage(UIImage(named: "myAddedPlace_ZtoA"), for: .normal)
                   self.collectionView.reloadData()
                    
               } else {
                   sortFilter.setImage(UIImage(named: "myAddedPlace_AtoZ"), for: .normal)
                   self.collectionView.reloadData()
               }
    }

    func setupView(){

        view.addSubviews(retangle,backButton,header)
        retangle.addSubviews(sortFilter,collectionView)

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

        sortFilter.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-23)
            make.height.width.equalTo(22)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
    }
}

extension MyAddedPlacesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sortedmyArrayAtoZ.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MyAddedPlaceCVC else {return UICollectionViewCell()}
        
        if isButtonActive {
            sortFilter.setImage(UIImage(named: "myAddedPlace_ZtoA"), for: .normal)
            cell.configure(item: viewModel.sortedmyArrayAtoZ[indexPath.row])
            
        } else {
            sortFilter.setImage(UIImage(named: "myAddedPlace_AtoZ"), for: .normal)
            cell.configure(item: viewModel.sortedmyArrayZtoA[indexPath.row])

        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.main.bounds.width - 48, height: 89)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = VisitDetailVC()
        
        if isButtonActive {
            vc.postedID = viewModel.sortedmyArrayAtoZ[indexPath.row].id
        } else {
            vc.postedID = viewModel.sortedmyArrayZtoA[indexPath.row].id
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}


