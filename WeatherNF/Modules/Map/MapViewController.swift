//
//  MapViewController.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 24.06.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: ParentViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var presenter: MapPresenterProtocol?

    var latitude:   Double?
    var longitude:  Double?
    
    private var uaСities = ["Kyiv", "Odessa","Dnipropetrovsk", "Kharkiv","Kryvyi-Rih","Cherkasy",
                             "Chernihiv","Chernivtsi","Ivano-Frankivsk","Kherson",
                             "Khmelnytskyi","Kirovohrad","Luhansk","Lviv","Mykolaiv","Poltava","Rivne","Sumy"]
    private var filteredCities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
//        searchButtonAction()
        setupLocationManager()
        setLoc()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.writeLocation(latitude: self.latitude!, longitude: self.longitude!)

        locationManager.stopUpdatingLocation()

    }
    
    fileprivate func setupMap() {
        self.navigationController?.navigationBar.isHidden = false
        sendAction = self
        self.presenter = MapViewPresenter(view: self)
    }

    fileprivate func writeLocation(latitude: Double, longitude: Double) {
        let coordArray = ["latitude" : "\(String(describing: latitude))","longitude":"\(String(describing: longitude))"]
        NotificationCenter.default.post(name: .gotLocation, object: nil, userInfo: coordArray)

    }

    fileprivate func setLoc() {
        let locationDistance: CLLocationDistance = 100000
        let coordinates = CLLocationCoordinate2D(latitude: 41.878113, longitude: -87.629)
        let coordinateRegion = MKCoordinateRegion(center: coordinates, latitudinalMeters: locationDistance, longitudinalMeters: locationDistance)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    @objc fileprivate func backActionButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)

    }
    
    fileprivate func searchButtonAction() {
        print("search")
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .black
        navigationController?.present(searchController, animated: true) {
        }
    }
    fileprivate func setupLocationManager() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
}
// MARK: - UISearchBarDelegate
extension MapViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredCities.removeAll()
        guard searchText != "" || searchText != " " else  {
            print("empty")
            return
        }
        for item in uaСities {
            let text = searchText.lowercased()
            let isArrayContain = item.lowercased().range(of: text)
            
            if isArrayContain != nil {
                filteredCities.append(item)
            }
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        dismiss(animated: true)
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil {
             print("ERROR")
            } else {
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                // get lat lon
                guard let latitude = response?.boundingRegion.center.latitude else {return}
                guard let longitude = response?.boundingRegion.center.longitude else {return}
                self.latitude = latitude
                self.longitude = longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                self.mapView.addAnnotation(annotation)
                
                // zoom
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
                
            }
        }
        
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - Searcher
extension MapViewController: SendSearch {
    func searchAction(_ go: String) {
        searchButtonAction()
    }
}


extension Notification.Name {
    static let gotLocation = Notification.Name("location")
}
extension MapViewController: MapViewProtocol {
    func setCountries(countries: [String]) {
        ///
    }
    
    
}




