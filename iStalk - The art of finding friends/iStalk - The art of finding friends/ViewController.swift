//
//  ViewController.swift
//  HealthStuff
//
//  Created by Wiem Ben Rim on 1/20/17.
//  Copyright © 2017 WBR. All rights reserved.
//

import UIKit
import GoogleMaps
import FacebookLogin
import FacebookCore


class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        var loggedIn = false
        if AccessToken.current != nil {
            loggedIn = true
            print("YESSSSS")
        }
        if loggedIn == false{
            let loginButton = LoginButton(readPermissions: [ .publicProfile ])
            loginButton.center = view.center
            
            view.addSubview(loginButton)

        }
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }

    }
    // Once the button is clicked, show the login dialog
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:18)
        mapView.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
}

