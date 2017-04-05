//
//  ViewController.swift
//  HealthStuff
//
//  Created by Wiem Ben Rim on 1/20/17.
//  Copyright © 2017 WBR. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
      let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    override func loadView() {
      
        
        var myLoc = CLLocationManager();
        let camera = GMSCameraPosition.camera(withLatitude: (myLoc.location?.coordinate.latitude)!, longitude: (myLoc.location?.coordinate.longitude)!, zoom: 19.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = (myLoc.location?.coordinate)!
        
        marker.title = "PennApps"
        marker.snippet = "Upenn"
        marker.map = mapView
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    @nonobjc func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            let locationManager = CLLocationManager()
            let camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!,longitude: (locationManager.location?.coordinate.latitude)!, zoom: 6.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        
        self.mapView.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
}

