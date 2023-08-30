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
    let VisitsDetailViewModelInstance = VisitsDetailViewModel()
   
    var gelenCevap: PDetailResponse?
    var gonderilenId: String?
    

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
//        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
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
        view.addSubviews(titleLabel, dateLabel, mapView, descriptionLabel)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
       
        label.font = Font.poppins(fontType: 600, size: 30).font
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
       
        guard let vd = VisitsDetailViewModelInstance.visitDetail?.createdAt else { return UILabel() }
        dateFormatter(visitDate: vd, label: label)
            
        return label
    }()
    
    func dateFormatter(visitDate: String, label: UILabel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: visitDate) {
            dateFormatter.dateFormat = "dd - MMMM - yyyy" // Ayın tam adını yazdırmak için
            label.text = dateFormatter.string(from: date)
        }
    }
    
        lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //mapView.delegate = self // Delegate'i ayarlama
        var long = 0.00
        var lat = 0.00
        // Örnek olarak İstanbul'un koordinatlarına bir işaretçi ekleyelim

        var Coordinate = CLLocationCoordinate2D(latitude: Float64(lat), longitude: Float64(long))
        let annotation = MKPointAnnotation()
        annotation.coordinate = Coordinate
        annotation.title = ""
        mapView.addAnnotation(annotation)

        // Haritayı belirli bir bölgeye yakınlaştırmak
        let region = MKCoordinateRegion(center: Coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        return mapView
    }()

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        let identifier = "locationMarker"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        if let pinImage = UIImage(named: "locationMarker") {
            let size = CGSize(width: 32, height: 42)

            UIGraphicsBeginImageContext(size)
            pinImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            annotationView?.image = resizedImage
        }

        return annotationView
    }

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
        
        
        guard let id = gonderilenId else { return }
        VisitsDetailViewModelInstance.getAllGalleryByPlaceID(id: id){
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        VisitsDetailViewModelInstance.fetchDetails(id: id) { success in
            DispatchQueue.main.async {
                if success {
                    print("başarılı")
                    self.descriptionLabel.text = self.VisitsDetailViewModelInstance.visitDetail?.description
                    self.titleLabel.text = self.VisitsDetailViewModelInstance.visitDetail?.title
                    self.dateLabel.text = self.VisitsDetailViewModelInstance.visitDetail?.createdAt
//                    self.mapView.annotation?.coordinate.latitude = self.VisitsDetailViewModelInstance.visitDetail?.latitude
//                    self.mapView.annotation?.coordinate.longitude = self.VisitsDetailViewModelInstance.visitDetail?.longitude
//                    self.mapView.annotation?.title = self.VisitsDetailViewModelInstance.visitDetail?.title

                    self.mapView.removeAnnotations(self.mapView.annotations)

                        // Yeni koordinatları ayarlıyoruz
                    let coordinate = CLLocationCoordinate2D(latitude: self.VisitsDetailViewModelInstance.visitDetail?.latitude ?? 0.00, longitude: self.VisitsDetailViewModelInstance.visitDetail?.longitude ?? 0.00)
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                    annotation.title = self.VisitsDetailViewModelInstance.visitDetail?.title ?? "Veri Gelmedi"
                    self.mapView.addAnnotation(annotation)

                        // Haritayı yeni koordinata odaklıyoruz
                        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                    self.mapView.setRegion(region, animated: true)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    let pNumber = self.VisitsDetailViewModelInstance.myArray.count
                    self.pageControl.numberOfPages = pNumber

                    if pNumber == 0 {
                        self.pageControl.isHidden = true
                    }
                    self.collectionView.reloadData()
                } else {
                    print("başarısız")
                    self.collectionView.reloadData()
                }
            }
        }

        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 16)
    }

    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: scrollContentView.frame.height)
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

extension VisitDetailVC: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 250)
        return size
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension VisitDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return VisitsDetailViewModelInstance.getImagesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VisitDetailCVC
        
        let image = VisitsDetailViewModelInstance.myArray[indexPath.row].imageUrl
        
        cell.configure(model: image)
    
        return cell
    }

}
