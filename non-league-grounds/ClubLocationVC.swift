//
//  ClubLocationVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 18/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class ClubLocationVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    
//    var club: Clubs!
    var pinTitle = String ()
    var pinSubTitle = String()
    var latitude = Double()
    var longitude = Double ()
    let locationManager = CLLocationManager()
    var geoFire: GeoFire!
    var geoFireRef: FIRDatabaseReference!

    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        print(pinTitle)
        print(pinSubTitle)
        print(longitude)
        print(latitude)

        self.navigationItem.title = "Location"
        
        // Create a location
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        
        // Create a span + Zoom leval
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        // Create a region
        let region = MKCoordinateRegion(center: location, span: span)
        
        // Set the region for the map
        self.mapView.setRegion(region, animated: true)
        
//        //Add a pin
        let pinAnnotationAtIndex = 0
        let pin = MKPointAnnotation()
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.setImage(UIImage(named: "mapDirections"), for: .normal)
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView: MKAnnotationView?
        let annoIdentifier = "Club"
        
        if annotation.isKind(of: MKUserLocation.self) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named: "pin")
        } else if let deqAnno = mapView.dequeueReusableAnnotationView(withIdentifier: annoIdentifier) {
            
            annotationView = deqAnno
            annotationView?.annotation = annotation
            
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annoIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn.setImage(UIImage(named: "map"), for: .normal)
            annotationView.rightCalloutAccessoryView = btn
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        print("Ground Location")
        
        if let anno = view.annotation as? ClubLocation {
            
            var place: MKPlacemark!
            if #available(iOS 10.0, *) {
                place = MKPlacemark(coordinate: anno.coordinate)
            } else {
                place = MKPlacemark(coordinate: anno.coordinate, addressDictionary: nil)
            }
            
            let destination = MKMapItem(placemark: place)
            destination.name = "Ground Location"
            let regionDistance: CLLocationDistance = 1000
            let regionSpan = MKCoordinateRegionMakeWithDistance(anno.coordinate, regionDistance, regionDistance)
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey:  NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving] as [String : Any]
            
            MKMapItem.openMaps(with: [destination], launchOptions: options)
            
            print("Above anno")
            print(anno.coordinate)
        }
    }

    @IBAction func mapTypeChanged(_ sender: AnyObject) {
        
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    @IBAction func backBtn(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
    }
}
