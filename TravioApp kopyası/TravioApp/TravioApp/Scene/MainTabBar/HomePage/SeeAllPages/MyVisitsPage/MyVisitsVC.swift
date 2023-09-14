//
//  MyVisitsVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 8.09.2023.
//
import UIKit

final class MyVisitsVC: UIViewController {
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
        label.text = "My Visits"
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
        cv.register(MyVisitsCollectionViewCell.self, forCellWithReuseIdentifier: "MyVisitsCollectionViewCell")
        cv.backgroundColor = ColorEnum.viewColor.uiColor
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    //MARK: - Variables
    private var viewModel = MyVisitsViewModel()
    private var isButtonActive = true
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchMyVisits(page: 1, limit: 10, completion: { errorMessage in
            if let errorMessage = errorMessage {
                self.showAlert(title: "Hata", message: errorMessage)
            } else {
                self.collectionView.reloadData()
            }
        })
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
extension MyVisitsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel.sortedmyArrayAtoZ?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyVisitsCollectionViewCell", for: indexPath) as? MyVisitsCollectionViewCell else {return UICollectionViewCell() }
        
        if isButtonActive {
            sortFilter.setImage(UIImage(named: "myAddedPlace_ZtoA"), for: .normal)
            guard let item = viewModel.sortedmyArrayAtoZ?[indexPath.row].place else { return cell}
            cell.configure(item: item)
            
        } else {
            sortFilter.setImage(UIImage(named: "myAddedPlace_AtoZ"), for: .normal)
            guard let item = viewModel.sortedmyArrayZtoA?[indexPath.row].place else { return cell }
            cell.configure(item: item)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 89)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = VisitDetailVC()
        
        if isButtonActive {
            guard let placeID = viewModel.sortedmyArrayAtoZ?[indexPath.row].place?.id else { return }
            vc.postedID = placeID
            
        } else {
            guard let placeID = viewModel.sortedmyArrayZtoA?[indexPath.row].place?.id else { return }
            vc.postedID = placeID
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
