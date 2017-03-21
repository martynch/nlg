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
let STORAGE_BASE = FIRStorage.storage().reference()


public var LEAGUE_KEY: String!
public var CLUB_KEY: String!
public var PLAYER_KEY: String!


class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_LEAGUES = DB_BASE.child("leagues")
    private var _REF_CLUBS = DB_BASE.child("clubs")
    private var _REF_PLAYERS = DB_BASE.child("player")
    
    private var _REF_LEAGUE_Images = STORAGE_BASE.child("league-crest")
    private var _REF_TEAM_IMAGES = STORAGE_BASE.child("team-crest")
    
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_LEAGUES: FIRDatabaseReference {
        return _REF_LEAGUES
    }
    
    var REF_CLUBS: FIRDatabaseReference {
        return _REF_CLUBS
    }
    
    var REF_PLAYERS: FIRDatabaseReference {
        return _REF_PLAYERS
    }
    
    var REF_TEAM__IMAGES: FIRStorageReference {
        return _REF_TEAM_IMAGES
    }
}
