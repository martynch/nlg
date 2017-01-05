//
//  ClubLocation.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 19/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ClubLocation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    var title: String?
    var subtitle: String?
    
    init (coordinate: CLLocationCoordinate2D) {
        
        self.coordinate = coordinate
        
//        self.coordinate = coordinate
//        self.latitude = coordinate.latitude
//        self.longitude = Float(coordinate.longitude)
    }
}
