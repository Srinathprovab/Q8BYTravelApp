//
//  MapViewVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 23/08/22.
//

import UIKit
import MapKit
import GoogleMaps

struct MapModel {
    var longitude =  String()
    var latitude =  String()
    var hotelname = String()
}


class MapViewVC: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var googleMapView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    static var newInstance: MapViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MapViewVC
        return vc
    }
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setupUI() {
        
        self.googleMapView.backgroundColor = .WhiteColor
        nav.titlelbl.text = "Map View"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction), for: .touchUpInside)
        
    }
    
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !mapModelArray.isEmpty {
            // Calculate the average latitude and longitude from mapModelArray
            let averageLatitude = mapModelArray.map { Double($0.latitude) ?? 0.0 }.reduce(0.0, +) / Double(mapModelArray.count)
            let averageLongitude = mapModelArray.map { Double($0.longitude) ?? 0.0 }.reduce(0.0, +) / Double(mapModelArray.count)
            
            // Set the camera to center on the average coordinates
            let camera = GMSCameraPosition.camera(withLatitude: averageLatitude, longitude: averageLongitude, zoom: 12.0)
            
            let gmsView = GMSMapView.map(withFrame: view.bounds, camera: camera)
            googleMapView.addSubview(gmsView)
            addMarkersToMap(gmsView)
            
            locationManager.stopUpdatingLocation() // You may want to stop updates after you have the user's location
        }
    }
    
    
    
    
    
    func addMarkersToMap(_ mapView: GMSMapView) {
        for mapModel in mapModelArray {
            if let latitude = Double(mapModel.latitude), let longitude = Double(mapModel.longitude) {
                // Create and configure markers based on the mapModel data
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                marker.title = mapModel.hotelname
                // Customize the marker as needed
                
                // Add the marker to the map
                marker.map = mapView
            } else {
                print("Error: Invalid latitude or longitude values in mapModel.")
            }
        }
    }
    
    
    
    @objc func backbtnAction() {
        callapibool = false
        dismiss(animated: true)
    }
    
    
}


