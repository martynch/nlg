//
//  Players.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 27/02/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import Foundation

class Players {
    
    fileprivate var _playerFirstName: String!
    fileprivate var _playerLastName: String!
    fileprivate var _playerKey: String!
    
    var playerFirstName: String {
        if _playerFirstName == nil {
            _playerFirstName = "First"
        }
        return _playerLastName
    }
    
    var playerLastName: String {
        if _playerLastName == nil {
            _playerLastName = "Last"
        }
        return _playerLastName
    }
    
    var playerKey: String {
        if _playerKey == nil {
            _playerKey = ""
        }
        return _playerKey
    }
    
    init(playerFirstName: String, dictionary: Dictionary<String, Any>) {
        self._playerFirstName = playerFirstName
        
        if let playerFirstName = dictionary["player"] as? String {
            self._playerFirstName = playerFirstName
        }
    }
    
    init(playerKey: String, dictionary: Dictionary<String, Any>) {
        self._playerKey = playerKey
        
        if let playerFirstName = dictionary["PlayerFirstName"] as? String {
            self._playerFirstName = playerFirstName
        }
        
        if let playerLastName = dictionary["playerLastName"] as? String {
            self._playerLastName = playerLastName
        }
    }
}
