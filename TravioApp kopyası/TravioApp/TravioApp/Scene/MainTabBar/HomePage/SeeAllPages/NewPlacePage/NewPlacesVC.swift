//
//  NewPlaceVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 8.09.2023.
//
import UIKit

final class NewPlacesVC: UIViewController {
    //MARK: - Views
    private lazy var rectangle:CustomBackgroundRectangle = {
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
        label.text = "New Places"
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
        cv.register(NewPlacesCollectionViewCell.self, forCellWithReuseIdentifier: "NewPlacesCollectionViewCell")
        cv.backgroundColor = ColorEnum.viewColor.uiColor
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    //MARK: - Variables
    private var viewModel = NewPlacesViewModel()
    private var isButtonActive = true
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchNewPlaces(limit: 10) { errorMessage in
            if let errorMessage = errorMessage {
                self.showAlert(title: "Hata", message: errorMessage)
            } else {
                self.collectionView.reloadData()
            }
        }
    }
    //MARK: - Functions
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sortFilterTapped() {
        isButtonActive.toggle()
        
        if isButtonActive {
            sortFilter.setImage(UIImage(named: "myAddedPlace_AtoZ"), for: .normal)
            self.collectionView.reloadData()
            
        } else {
            sortFilter.setImage(UIImage(named: "myAddedPlace_ZtoA"), for: .normal)
            self.collectionView.reloadData()
        }
    }
    
    private func setupViews(){
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        self.view.addSubviews(rectangle,backButton,header)
        self.rectangle.addSubviews(sortFilter,collectionView)
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        backButton.topToSuperview(offset: 36, usingSafeArea: true)
        backButton.leadingToSuperview(offset: 20)
        backButton.height(21.5)
        backButton.width(24)
        
        header.leadingToTrailing(of: backButton, offset: 24)
        header.topToSuperview(offset: 23, usingSafeArea: true)
        
        rectangle.topToBottom(of: header, offset: 54)
        rectangle.leadingToSuperview()
        rectangle.trailingToSuperview()
        rectangle.bottomToSuperview()
        
        sortFilter.topToSuperview(offset: 24)
        sortFilter.trailingToSuperview(offset: 23)
        sortFilter.height(22)
        sortFilter.width(22)
        
        collectionView.leadingToSuperview()
        collectionView.trailingToSuperview()
        collectionView.bottomToSuperview()
        collectionView.topToSuperview(offset: 60)
    }
}
//MARK: - UICollectionView Extensions
extension NewPlacesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sortedmyArrayAtoZ.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewPlacesCollectionViewCell", for: indexPath) as? NewPlacesCollectionViewCell else {return UICollectionViewCell() }
        
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
            vc.placeId = viewModel.sortedmyArrayAtoZ[indexPath.row].id
            
        } else {
            vc.placeId = viewModel.sortedmyArrayZtoA[indexPath.row].id
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}




