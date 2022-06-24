//
//  MapViewController.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 24.06.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchBaar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
//    public var lat: Double?
//    public var lon: Double

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func configSearchBar() {
        searchBaar.layer.cornerRadius = 10
    }
    fileprivate func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    @IBAction func backActionButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

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
