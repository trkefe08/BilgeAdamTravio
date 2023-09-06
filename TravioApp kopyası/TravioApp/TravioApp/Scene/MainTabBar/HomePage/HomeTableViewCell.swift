//
//  HomeTableViewCell.swift
//  TravioApp
//
//  Created by Tarik Efe on 5.09.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = ColorEnum.viewColor.uiColor
        cv.showsHorizontalScrollIndicator = false
        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        cv.backgroundColor = .clear
        return cv
    }()
    
    var popularLastAndVisits: [Place] = []


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubviews(collectionView)
        setupLayout()
    }
    
    func setupLayout() {
        collectionView.edgesToSuperview()
    }
    
    func configureCell(model: [Place]) {
        popularLastAndVisits = model
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
}

extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 86, height: 178)
    }
}

extension HomeTableViewCell: UICollectionViewDataSource {
    
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
