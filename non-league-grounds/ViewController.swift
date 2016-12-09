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

    @IBOutlet weak var clubCountBtn: UILabel!
    
    var league: Leagues!
    var clubs: Clubs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Home"
        
        DataService.ds.REF_LEAGUES.observe(.value, with:  { snapshot in
            let leagueCount = snapshot.childrenCount
            print(snapshot.childrenCount)
            self.leagueCountBtn.text = leagueCount.description
            
        }) { (error) in
            print(error.localizedDescription)
            print("CHET: local error")
            
        }
        
        DataService.ds.REF_CLUBS.observe(.value, with:  { snapshot in
            let clubCount = snapshot.childrenCount
            print(snapshot.childrenCount)
            
            // Button displays the current league count
            self.clubCountBtn.text = clubCount.description
            
        }) { (error) in
            print(error.localizedDescription)
            print("CHET: local error")
            
        }
    }
}

