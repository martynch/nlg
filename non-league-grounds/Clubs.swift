//
//  Clubs.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import Foundation

class Clubs {
    
    fileprivate var _clubName: String!
    fileprivate var _groundName: String?
    fileprivate var _chairman: String?
    fileprivate var _address1: String?
    fileprivate var _address2: String?
    fileprivate var _address3: String?
    fileprivate var _address4: String?
    fileprivate var _poscCode: String?
    fileprivate var _email: String?
    fileprivate var _webUrl: String?
    fileprivate var _latitude: Double?
    fileprivate var _longitude: Float?    
    fileprivate var _clubKey: String!
    fileprivate var _crest: UIImage!
    
    
    var clubName: String! {
        if _clubName == nil {
            _clubName = ""
        }
        return _clubName
    }
    
    var groundName: String {
        if _groundName == nil {
            _groundName = ""
        }
        return _groundName!
    }
    
    var chairman: String {
        if _chairman == nil {
            _chairman = ""
        }
        return _chairman!
    }
    
    var address1: String {
        if _address1 == nil {
            _address1 = ""
        }
        return _address1!
    }
    
    var address2: String {
        if _address2 == nil {
            _address2 = ""
        }
        return _address2!
    }
    
    var address3: String {
        if _address3 == nil {
            _address3 = ""
        }
        return _address3!
    }
    
    var address4: String {
        if _address4 == nil {
            _address4 = ""
        }
        return _address4!
    }
    
    var postCode: String {
        if _poscCode == nil {
            _poscCode = ""
        }
        return _poscCode!
    }
    
    var email: String {
        if _email == nil {
            _email = ""
        }
        return _email!
    }
    
    var webUrl: String {
        if _webUrl == nil {
            _webUrl = ""
        }
        return _webUrl!
    }
    
    var clubKey: String {
        if _clubKey == nil {
            _clubKey = ""
        }
        return _clubKey
    }
    
    var latitude: Double {
        if _latitude == nil {
            _latitude = 0
        }
        return _latitude!
    }
    
    var longitude: Float {
        if _longitude == nil {
            _longitude = 0
        }
        return _longitude!
    }
    
    var crest: UIImage {
        if _crest == nil {
            _crest = UIImage(named: "logo.png")
        }
        return _crest
    }
    
    init(clubName: String, dictionary: Dictionary<String, Any>) {
        self._clubName = clubName
        
        if let clubName = dictionary["clubs"] as? String {
            self._clubName = clubName
        }
    }
    
  
    // convert data to dictionary
    init(clubKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._clubKey = clubKey
        
        if let clubDetails = dictionary["clubName"] as? String {
            self._clubName = clubDetails
        }
        
        if let groundName = dictionary["groundName"] as? String {
            self._groundName = groundName
        }
        
        if let chairman = dictionary["chairmanName"] as? String {
            self._chairman = chairman
        }
        
        if let address1 = dictionary["address1"] as? String {
            self._address1 = address1
        }
        
        if let address2 = dictionary["address2"] as? String {
            self._address2 = address2
        }
        
        if let address3 = dictionary["address3"] as? String {
            self._address3 = address3
        }
        
        if let address4 = dictionary["address4"] as? String {
            self._address4 = address4
        }
        
        if let postCode = dictionary["postCode"] as? String {
            self._poscCode = postCode
        }
        
        if let email = dictionary["email"]  as? String {
            self._email = email
        }
        
        if let webUrl = dictionary["webUrl"] as? String {
            self._webUrl = webUrl
        }
        
        if let latitude = dictionary["latitude"] as? Double {
            self._latitude = latitude
        }
        
        if let longitude = dictionary["longitude"] as? Float {
            self._longitude = longitude
        }
        
        if let crest = dictionary["crest"] as? UIImage {
            self._crest = crest
        }
    }
}
