//
//  ViewController.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var leagueCountBtn: UILabel!
    @IBOutlet weak var divisionCountBtn: UILabel!
    @IBOutlet weak var clubCountBtn: UILabel!
    
    var league: Leagues!
    var division: Divisions!
    var clubs = [Clubs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CHET: Got to Home Page")
        
        self.navigationItem.title = "Home"
        
        DataService.ds.REF_LEAGUES.observe(.value, with:  { snapshot in
            
            print("Did we get to DataService?")
            let leagueCount = snapshot.childrenCount
            
            print(leagueCount)
            print(snapshot.childrenCount)
            
            // Button displays the current league count
            self.leagueCountBtn.text = leagueCount.description
            
        })
    }
    
}

