//
//  MapViewController.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 24.06.2022.
//

import UIKit
import MapKit
import CoreLocation


protocol SendLocation: AnyObject {
    func sendLocation(latitude: Double?, longitude: Double?)
}

class MapViewController: ParentViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    weak var sendLocation: SendLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        sendAction = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    

    fileprivate func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    @objc fileprivate func backActionButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    fileprivate func searchButtonAction() {
        print("search")
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationController?.present(searchController, animated: true) {
        }
    }
    
    
}
// MARK: - UISearchBarDelegate
extension MapViewController: UISearchBarDelegate {
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
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                self.sendLocation?.sendLocation(latitude: latitude, longitude: longitude)
//                print(latitude)
//                print(longitude)
                
                // zoom
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
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
