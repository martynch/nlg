//
//  Leagues.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import Foundation

class Leagues {
    
    private var _leagueName: String!
    private var _leagueKey: String!
    
    var leagueName: String {
        if _leagueName == nil {
            _leagueName = ""
        }
        return _leagueName
    }
    
    var leagueKey: String {
        if _leagueKey == nil {
            _leagueKey = ""
        }
        return _leagueKey
    }
    
    init(leagueKey: String, dictionary: Dictionary<String, Any>) {
        self._leagueKey = leagueKey
        
    }
    
    init(leagueName: String, dictionary: Dictionary<String, Any>) {
        self._leagueName = leagueName
        
        if let leagueName = dictionary["league"] as? String {
            self._leagueName = leagueName
        }
        
    }
}
