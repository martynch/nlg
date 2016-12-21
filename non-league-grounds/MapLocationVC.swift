//
//  MapLocationVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 19/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class MapLocationVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var mapHasCentredOnce = false
    var geoFire: GeoFire!
    var geoFireRef: FIRDatabaseReference!
    var club: Clubs!
    var pinTitle = String ()
    var pinSubTitle = String()
    var latitude = String()
    var longitude = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        // Create a location
        let location = CLLocationCoordinate2DMake(52.899842, -1.168095)
        
        // Create a span + Zoom leval
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        // Create a region
        let region = MKCoordinateRegion(center: location, span: span)
        
        // Set the region for the map
        self.mapView.setRegion(region, animated: true)
        
        //        //Add a pin
        let pinAnnotationAtIndex = 0
        let pin = MKPointAnnotation()
        pin.coordinate = location
        pin.title = pinTitle
        pin.subtitle = pinSubTitle
        self.mapView.addAnnotation(pin)
        mapView.selectAnnotation(mapView.annotations[pinAnnotationAtIndex], animated: true)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
       
        if let loc = userLocation.location {
            
            if !mapHasCentredOnce {
                centerMapOnLocation(location: loc)
                mapHasCentredOnce = true
            }
        }
    }
    
    }
