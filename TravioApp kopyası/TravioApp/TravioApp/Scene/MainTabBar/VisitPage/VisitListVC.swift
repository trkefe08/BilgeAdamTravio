//
//  VisitListVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//
import UIKit
import TinyConstraints
import Kingfisher

class VisitListVC: UIViewController {
    let viewModel = VisitsViewModel()
    let visitCVCInstance = VisitCVC()
    
    var dizi: [Visit] = []

    private lazy var loadingIndicatorView:UIView = {
        let view = UIView()
        view.backgroundColor = .blue

        return view
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white

        return indicator
    }()
    
    private lazy var retangle: UIView = {
        let view = CustomBackgroundRectangle()
        
        return view
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "My Visits"
        label.font = Font.poppins(fontType: 600, size: 36).font
        label.textColor = .white
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 45, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 16
        cv.delegate = self
        cv.dataSource = self
        cv.register(VisitCVC.self, forCellWithReuseIdentifier: "CustomCell")
        cv.backgroundColor = ColorEnum.viewColor.uiColor
        
        return cv
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchVisitList { result in
            DispatchQueue.main.async {
                self.dizi = result.data.visits
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        showLoadingIndicator()
        loadingIndicatorView.isHidden = true
        viewModel.fetchVisitList(callback: { result in
            DispatchQueue.main.async {
                self.dizi = result.data.visits
                self.collectionView.reloadData()
            }
            
        })
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
    }
    
    
    func setupViews() {
        view.backgroundColor = ColorEnum.travioBackground.uiColor
        navigationController?.navigationBar.isHidden = true
        
        view.addSubviews(retangle,header,loadingIndicatorView)
        retangle.addSubviews(collectionView)
        loadingIndicatorView.addSubview(loadingIndicator)
        view.bringSubviewToFront(loadingIndicatorView)
        
        setupLayouts()
    }
    
    func setupLayouts() {
        retangle.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().offset(0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(128)
        }
        
        header.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        loadingIndicatorView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
}

extension VisitListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dizi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? VisitCVC else { return UICollectionViewCell() }
        
        let travel = dizi[indexPath.item]
        cell.configure(with: travel)
        
        hideLoadingIndicator()
        loadingIndicatorView.isHidden = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 56, height: 219)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let VisitsDetailVCInstance = VisitDetailVC()
        VisitsDetailVCInstance.postedID = dizi[indexPath.row].placeId
        
        self.navigationController?.pushViewController(VisitsDetailVCInstance, animated: true)
    }
}

