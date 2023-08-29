//
//  VisitDetailVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import MapKit
import TinyConstraints

class VisitDetailVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInsetAdjustmentBehavior = .never
        cv.delegate = self
        cv.dataSource = self
        cv.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "DetailCollectionViewCell")
        cv.backgroundColor = .clear
        return cv
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        if let image = UIImage(named: "Group 10") {
            btn.setImage(image, for: .normal)
        }
        return btn
    }()
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.isEnabled = false
        pc.backgroundColor = .white
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .black
        return pc
    }()
    
    
    private lazy var scrollView: UIScrollView = {
        let sc = UIScrollView()
        sc.isScrollEnabled = true
        return sc
    }()
    
    private lazy var contentView: UIView = {
        let v = UIView()
        return v
    }()
    
    private lazy var locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = ColorEnum.fontColor.uiColor
        lbl.font = UIFont(name: "Poppins-Bold", size: 30)
        return lbl
    }()
    
    private lazy var visitDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = ColorEnum.fontColor.uiColor
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        return lbl
    }()
    
    private lazy var creatorLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = ColorEnum.btnDefaultBackground.uiColor
        lbl.font = UIFont(name: "Poppins-Regular", size: 10)
        return lbl
    }()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.isScrollEnabled = false
        map.delegate = self
        map.showsUserLocation = true
        return map
    }()
    
    private lazy var infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Poppins-Medium", size: 12)
        return lbl
    }()
    
    var visitId = ""
    var viewModel = VisitDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.delegate = self
        viewModel.fetchDetails(id: visitId)
        viewModel.fetchGallery(id: visitId)
    }
    
    override func viewDidLayoutSubviews() {
        pageControl.layer.cornerRadius = pageControl.frame.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contentView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: 1000)
        scrollView.contentSize = contentView.frame.size
    }
    
    func setupViews() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        self.view.addSubviews(collectionView,backButton,pageControl,scrollView)
        self.scrollView.addSubviews(contentView)
        self.contentView.addSubviews(locationLabel, visitDateLabel, creatorLabel, mapView, infoLabel)
        setupLayout()
    }
    
    func setupLayout() {
        collectionView.edgesToSuperview(excluding: .bottom, usingSafeArea: false)
        collectionView.height(249)
        
        backButton.topToSuperview(offset: 32, usingSafeArea: true)
        backButton.leadingToSuperview(offset: 24)
        backButton.height(40)
        backButton.width(40)
        backButton.bringSubviewToFront(collectionView)
        
        
        pageControl.centerXToSuperview()
        pageControl.bottom(to: collectionView, offset: -8)
        pageControl.width(120)
        pageControl.height(44)
        pageControl.bringSubviewToFront(collectionView)
        
        scrollView.topToBottom(of: collectionView)
        scrollView.edgesToSuperview(excluding: .top)
        contentView.edgesToSuperview()
        contentView.height(infoLabel.frame.height + 20)
        contentView.width(to: scrollView)
        
        locationLabel.topToSuperview(offset: 24)
        locationLabel.leadingToSuperview(offset: 24)
        locationLabel.height(45)
        
        visitDateLabel.topToBottom(of: locationLabel)
        visitDateLabel.leading(to: locationLabel)
        visitDateLabel.height(21)
        
        creatorLabel.topToBottom(of: visitDateLabel)
        creatorLabel.leading(to: visitDateLabel)
        
        mapView.topToBottom(of: visitDateLabel, offset: 24)
        mapView.leadingToSuperview(offset: 16)
        mapView.trailingToSuperview(offset: 16)
        mapView.height(227)
        
        infoLabel.topToBottom(of: mapView, offset: 24)
        infoLabel.leadingToSuperview(offset: 16)
        infoLabel.trailingToSuperview(offset: 16)
        //infoLabel.bottomToSuperview(offset: -16)
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateMapWithLocationInfo(_ locationInfo: [Double]) {
        if locationInfo.count == 2 {
            centerMapOnLocation(locations: locationInfo)
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: locationInfo[0], longitude: locationInfo[1])
            mapView.addAnnotation(annotation)
        }
    }
    
    func centerMapOnLocation(locations: [Double]) {
        if locations.count >= 2 {
            let latitude = locations[0]
            let longitude = locations[1]
            
            let location = CLLocation(latitude: latitude, longitude: longitude)
            
            let regionRadius: CLLocationDistance = 10000
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
}

extension VisitDetailVC: VisitDetailViewModelDelegate {
    func visitDetailLoaded() {
        locationLabel.text = viewModel.getLocationName()
        visitDateLabel.text = viewModel.getVisitDateName()
        infoLabel.text = viewModel.getInformation()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        pageControl.numberOfPages = viewModel.getGallery()
        updateMapWithLocationInfo(viewModel.getMKInfo())
    }
    
}

extension VisitDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension VisitDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getGallery()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as? DetailCollectionViewCell, let model = viewModel.getDetailCellConfigure(at: indexPath.row) else { return UICollectionViewCell()}
        cell.configureCell(model: model)
        return cell
    }
    
    
}

extension VisitDetailVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil // Kullanıcı konumu için özel görünüm yok
        }
        
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
