//
//  DataServices.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()


public var LEAGUE_KEY: String!
private var CLUB_KEY: String!


class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_LEAGUES = DB_BASE.child("leagues")
    private var _REF_CLUBS = DB_BASE.child("clubs")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_LEAGUES: FIRDatabaseReference {
        return _REF_LEAGUES
    }
    
    var REF_CLUBS: FIRDatabaseReference {
        return _REF_CLUBS
    }
}
