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
    let viewModel = VisitsDetailViewModel()
    
    var postedID: String?
    var placeId: String?
    var isVisited: Bool?
    
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
        mapView.delegate =  self
        
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
    
    private lazy var visitButton:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(visitButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var btnImageView:UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private lazy var btnlabel:UILabel = {
        let lbl = UILabel()
        lbl.font = Font.poppins(fontType: 300, size: 10).font
        lbl.textColor = .white
        
        return lbl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        guard let id = postedID ?? placeId else { return }
        viewModel.checkVisit(id: id) { check in
            if check == "success" {
                self.deleteButton()
            } else {
                self.addButton()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGallery()
        updateComponents()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 16)
        visitButton.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 16)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: scrollContentView.frame.height)
    }
    
    func getGallery() {
        guard let id = postedID ?? placeId else { return }
        viewModel.getAllGalleryByPlaceID(id: id) {
            DispatchQueue.main.async {
                
                let pNumber = self.viewModel.myArray.count
                self.pageControl.numberOfPages = pNumber
                
                if pNumber == 0 {
                    self.pageControl.isHidden = true
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    private func deleteButton() {
        btnImageView.image = UIImage(named: "delete")
        btnlabel.text = "Delete"
    }
    
    private func addButton() {
        btnImageView.image = UIImage(named: "visits_add")
        visitButton.backgroundColor = ColorEnum.travioBackground.uiColor
        btnlabel.text = "Add"
    }
    
   private func updateComponents() {
//       if isVisited == false {
//           addButton()
//       } else {
//           deleteButton()
//       }
//
        guard let id = postedID ?? placeId  else { return }
        viewModel.fetchDetails(id: id) { success in
            DispatchQueue.main.async {
                guard let vst = self.viewModel.visitDetail else {return}
                self.descriptionLabel.text = vst.description
                self.titleLabel.text = vst.title
                self.createdBy.text = "created by @\(vst.creator)"
                self.dateFormatter(visitDate: vst.createdAt, label: self.dateLabel)
                
                updateMap()
            }
        }
        
         func updateMap(){
            guard let vst = self.viewModel.visitDetail else { return }
            let coordinate = CLLocationCoordinate2D(latitude: vst.latitude, longitude: vst.longitude )
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = vst.title
            self.mapView.addAnnotation(annotation)
            
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            self.mapView.setRegion(region, animated: true)
            
        }
        
    }
    
    private func dateFormatter(visitDate: String, label: UILabel) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        if let date = dateFormatter.date(from: visitDate) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            label.text = dateFormatter.string(from: date)
        } else {
            print("Tarih dönüştürülemedi")
        }
    }
    
    
    private func setupViews() {
        let yourView = UIView()
        yourView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yourView)
        yourView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.backgroundColor = ColorEnum.viewColor.uiColor
        navigationController?.isNavigationBarHidden = true
        
        view.addSubviews(collectionView, pageControl, backButton, scrollView, visitButton)
        view.bringSubviewToFront(visitButton)
        visitButton.addSubviews(btnImageView,btnlabel)
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
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(24)
            make.height.width.equalTo(40)
        }
        
        visitButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(50)
        }
        
        btnImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(22.5)
            make.height.equalTo(18)
            make.centerX.equalToSuperview()
        }
        
        btnlabel.snp.makeConstraints { make in
            make.top.equalTo(btnImageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func visitButtonTapped() {
        if btnlabel.text == "Add" {
            viewModel.addVisit(parameters: ["place_id": placeId, "visited_at": "2023-08-10T00:00:00Z"]) {
                self.deleteButton()
                self.visitButton.backgroundColor = .clear
                self.showAlert(message: "Visit Listenize Başarıyla Eklendi")
            }
        } else {
            guard let id = postedID ?? placeId else { return }
            viewModel.deleteVisit(id: id) {
                self.addButton()
                self.showAlert(message: "Visit Listenizden Başarıyla Kaldırıldı")
            }
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Bilgi", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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
        return viewModel.getImagesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? VisitDetailCVC else {return UICollectionViewCell()}
        
        let image = viewModel.myArray[indexPath.row].imageUrl
        
        cell.configure(model: image)
        
        return cell
    }
}

extension VisitDetailVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationIdentifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "map 1")  // Özelleştirilmiş pin görüntüsü
        return annotationView
    }
}
