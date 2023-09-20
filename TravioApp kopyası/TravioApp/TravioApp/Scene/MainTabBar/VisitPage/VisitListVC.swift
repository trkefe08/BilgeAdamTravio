//
//  VisitListVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//
import UIKit
import TinyConstraints
import Kingfisher
import SkeletonView

final class VisitListVC: UIViewController {
    //MARK: - Views
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
    //MARK: - Variables
    var viewModel = VisitsViewModel()
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchVisitList { errorMessage in
            if let errorMessage = errorMessage {
                self.showAlert(title: "Hata!", message: errorMessage)
            } else {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        collectionView.isSkeletonable = true
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .clouds, secondaryColor: ColorEnum.travioBackground.uiColor), animation: animation, transition: .crossDissolve(0.25))
        viewModel.fetchVisitList { errorMessage in
            if let errorMessage = errorMessage {
                self.showAlert(title: "Hata!", message: errorMessage)
            } else {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.collectionView.stopSkeletonAnimation()
                    self.collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                }
            }
        }
    }
    //MARK: - Functions
    private func setupViews() {
        view.backgroundColor = ColorEnum.travioBackground.uiColor
        navigationController?.navigationBar.isHidden = true
        view.addSubviews(retangle,header)
        retangle.addSubviews(collectionView)
        setupLayouts()
    }
    
    private func setupLayouts() {
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
    }
}
//MARK: - UICollectionView Extension
extension VisitListVC: UICollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel.getCount else { return 0}
        return count
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "CustomCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel.getCount else { return 0}
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? VisitCVC else { return UICollectionViewCell() }
        let model = viewModel.getPlacesIndex(at: indexPath.row)
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 56, height: 219)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VisitDetailVC()
        vc.postedID = viewModel.getPlacesId(at: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

