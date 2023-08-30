//
//  VisitDetailVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 31.08.2023.
//

import MapKit
import SDWebImage
import SnapKit
import UIKit

class VisitDetailVC: UIViewController {
    let vdVM = VisitsDetailViewModel()
   
    var postedID: String?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(VisitDetailCVC.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundStyle = .prominent
        pageControl.currentPage = 0
        pageControl.allowsContinuousInteraction = false

        pageControl.pageIndicatorTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = ColorEnum.viewColor.uiColor
        scrollView.addSubview(scrollContentView)
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        view.addSubviews(titleLabel, createdBy, dateLabel, mapView, descriptionLabel)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
       
        label.font = Font.poppins(fontType: 600, size: 30).font
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
       
        return label
    }()
    
    private lazy var createdBy: UILabel = {
        let label = UILabel()
        label.text = "created"
        label.font = Font.poppins(fontType: 400, size: 10).font
        label.textColor = #colorLiteral(red: 0.6642268896, green: 0.6642268896, blue: 0.6642268896, alpha: 1)
        
        return label
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        return mapView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
      
        label.font = Font.poppins(fontType: 500, size: 14).font
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "visits_back"), for: .normal)
        
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      getGallery()
      updateComponents()
      setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 16)
    }

    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: scrollContentView.frame.height)
    }
    
    func getGallery() {
        guard let id = postedID else { return }
        vdVM.getAllGalleryByPlaceID(id: id) {
            DispatchQueue.main.async {
                
                let pNumber = self.vdVM.myArray.count
                self.pageControl.numberOfPages = pNumber

                if pNumber == 0 {
                    self.pageControl.isHidden = true
                }
                self.collectionView.reloadData()
     
            }
            
        }
    }
    
    
    func updateComponents() {
        
        guard let id = postedID else { return }
        vdVM.fetchDetails(id: id) { success in
            DispatchQueue.main.async {
                guard let vst = self.vdVM.visitDetail else {return}
                    self.descriptionLabel.text = vst.description
                    self.titleLabel.text = vst.title
                    self.createdBy.text = "created By @\(vst.creator)"
                    self.dateFormatter(visitDate: vst.createdAt, label: self.dateLabel)
                       
                    updateMap()
            
            }
        }
        
        func updateMap(){
            guard let vst = self.vdVM.visitDetail else {return}
            // Yeni koordinatları ayarlıyoruz
            let coordinate = CLLocationCoordinate2D(latitude: vst.latitude, longitude: vst.longitude )
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = vst.title
            self.mapView.addAnnotation(annotation)

            // Haritayı yeni koordinata odaklıyoruz
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            self.mapView.setRegion(region, animated: true)

        }
        
    }
    func dateFormatter(visitDate: String, label: UILabel) {
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        if let date = dateFormatter.date(from: visitDate) {
            dateFormatter.dateFormat = "dd - MMMM - yyyy"
            label.text = dateFormatter.string(from: date)
        } else {
            print("Tarih dönüştürülemedi")
        }
    }
    
    private func setupViews() {
        // safe areayı kapatan kod blogu
        let yourView = UIView()
        yourView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yourView)
        yourView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.backgroundColor = ColorEnum.viewColor.uiColor
        navigationController?.isNavigationBarHidden = true
       
        view.addSubviews(collectionView, pageControl, backButton, scrollView)
    
        setupLayout()
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(collectionView.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview().offset(26)
        }
        
        createdBy.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.leading.equalToSuperview().offset(24)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(227)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.bottom).offset(20)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.equalToSuperview().offset(24)
            make.height.width.equalTo(40)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension VisitDetailVC: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 250)
        return size
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vdVM.getImagesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? VisitDetailCVC else {return UICollectionViewCell()}
        
        let image = vdVM.myArray[indexPath.row].imageUrl
        
        cell.configure(model: image)
        
        return cell
    }
}
