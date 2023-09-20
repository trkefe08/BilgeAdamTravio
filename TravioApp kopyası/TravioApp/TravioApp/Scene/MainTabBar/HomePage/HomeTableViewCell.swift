//
//  HomeTableViewCell.swift
//  TravioApp
//
//  Created by Tarik Efe on 5.09.2023.
//

import UIKit
import SkeletonView

protocol HomeTableViewCellDelegate: AnyObject {
    func didSelectItem(with model: Place)
}

final class HomeTableViewCell: UITableViewCell {
    //MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        cv.showsHorizontalScrollIndicator = false
        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        return cv
    }()
    //MARK: - Variables
    weak var delegate: HomeTableViewCellDelegate?
    var popularLastAndVisits: [Place] = []
    //MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func setupViews() {
        self.isSkeletonable = true
        contentView.isSkeletonable = true
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .clouds), animation: nil, transition: .crossDissolve(0.25))
        self.backgroundColor = ColorEnum.viewColor.uiColor
        self.contentView.backgroundColor = .clear
        self.contentView.addSubviews(collectionView)
        setupLayout()
    }
    
    private func setupLayout() {
        collectionView.edgesToSuperview()
    }
    
    func configureCell(model: [Place]) {
        popularLastAndVisits = model
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.stopSkeletonAnimation()
            self.collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }
        
    }
    
}
//MARK: - CollectionViewCell Extensions
extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 86, height: 178)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedModel = popularLastAndVisits[indexPath.item]
        delegate?.didSelectItem(with: selectedModel)
    }
    
}

extension HomeTableViewCell: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "HomeCollectionViewCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularLastAndVisits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularLastAndVisits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        let model = popularLastAndVisits[indexPath.row]
        cell.configureCell(model: model)
        return cell
    }
}
