//
//  ClubLocation.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 19/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import Foundation
import MapKit

class ClubLocation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    var latitude: Double
    var longitude: Float
    
    init (coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.latitude = coordinate.latitude
        self.longitude = Float(coordinate.longitude)
    }
}
