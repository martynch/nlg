//
//  Leagues.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import Foundation

class Leagues {
    
    fileprivate var _leagueName: String!
    fileprivate var _leagueKey: String!
    
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
        
        if let leagueName = dictionary["leagueName"] as? String {
            self._leagueName = leagueName
        }
    }
}
