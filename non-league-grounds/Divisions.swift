//
//  Divisions.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import Foundation

class Divisions {
    
    //    private var _divisionDescription: String!
    fileprivate var _divisionKey: String!
    
    var divisionKey: String {
        if _divisionKey == nil {
            _divisionKey = ""
        }
        return _divisionKey
    }
    
    init(divisionKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._divisionKey = divisionKey
        
        //        print("From Division Class: \(divisionKey)")
        
    }
    
}
