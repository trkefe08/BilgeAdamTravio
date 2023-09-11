//
//  MapVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import MapKit
import TinyConstraints

//MARK: - Protocol
protocol AddAnnotationDelegate: AnyObject {
    func didAddAnnotation()
}

final class MapVC: UIViewController {
    
    let viewModel = MapViewModel()
    
    //MARK: - Views
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.isScrollEnabled = true
        map.delegate = self
        map.showsUserLocation = true
        map.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
        return map
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: "MapCollectionViewCell")
        cv.backgroundColor = .clear
        return cv
    }()
   
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.delegate = self
        viewModel.fetchPlaces() {
        }
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
            geoCoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print("Reverse geocoding error: \(error.localizedDescription)")
                    return
                }
                
                if let placemark = placemarks?.first {
                    if let country = placemark.country, let city = placemark.locality {
                        let vc = AddNewAnnotationVC()
                        vc.delegate = self
                        self.addNewAnnotationVC(with: city, country: country, latitude: coordinate.latitude, longitude: coordinate.longitude)
                    }
                }
            }
        }
    }
    
    private func updateMapWithLocationInfo(_ locationInfo: [Place]) {
        for location in locationInfo {
            let annotation = MKPointAnnotation()
            guard let latitude = location.latitude else { return }
            guard let longitude = location.longitude else { return }
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotation.title = location.title
            annotation.subtitle = location.description
            mapView.addAnnotation(annotation)
        }
        centerMapOnLocation(locations: locationInfo.first ?? Place())
    }
    
    private func centerMapOnLocation(locations: Place) {
        guard let latitude = locations.latitude else { return }
        guard let longitude = locations.longitude else { return }
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let regionRadius: CLLocationDistance = 100000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func addNewAnnotationVC(with city: String, country: String, latitude: Double, longitude: Double) {
        let vc = AddNewAnnotationVC()
        vc.cityName = city
        vc.delegate = self
        vc.countryName = country
        vc.latitude = latitude
        vc.longitude = longitude
        self.present(vc, animated: true)
    }
    
    //MARK: - Functions
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubviews(mapView, collectionView)
        setupLayout()
    }

    private func setupLayout() {
        mapView.edgesToSuperview()
        
        collectionView.edgesToSuperview(excluding: [.bottom, .top], usingSafeArea: true)
        collectionView.height(178)
        collectionView.bottomToSuperview(offset: -16, usingSafeArea: true)
        collectionView.bringSubviewToFront(mapView)
    }
}

//MARK: - MapView Extension
extension MapVC: MapViewModelDelegate {
    func mapLocationsLoaded() {
        updateMapWithLocationInfo(viewModel.getMapInfo())
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation as MKAnnotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            let customImage = UIImage(named: "map 1")
            annotationView?.image = customImage
        } else {
            annotationView?.annotation = annotation as any MKAnnotation
        }
        return annotationView
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation {
            if let index = viewModel.getIndexForAnnotation(annotation) {
                let indexPath = IndexPath(item: index, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
}
//MARK: - CollectionView Extension
extension MapVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 178)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VisitDetailVC()
        guard let id = viewModel.getMapCollectionId(at: indexPath.row) else { return }
        vc.placeId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MapVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getMapCollectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCollectionViewCell", for: indexPath) as? MapCollectionViewCell else {
            return UICollectionViewCell() }
        guard let model = viewModel.getMapCollectionDetails(at: indexPath.row) else { return cell }
        
        cell.configureCell(model: model)
        
        return cell
    }
    
}
//MARK: - Protocol Extension
extension MapVC: AddAnnotationDelegate {
    func didAddAnnotation() {
        viewModel.fetchPlaces() {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
