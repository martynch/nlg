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
    
    @IBOutlet weak var burgerMenu: UIBarButtonItem!
    
    
    var league: Leagues!
    var clubs: Clubs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        burgerMenu.target = revealViewController()
        burgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationItem.title = "Non-League Grounds"
        
        DataService.ds.REF_LEAGUES.observe(.value, with:  { snapshot in
            let leagueCount = snapshot.childrenCount
            self.leagueCountBtn.text = leagueCount.description
            
        }) { (error) in
            print(error.localizedDescription)
            print("CHET: local error")
        }
        
        DataService.ds.REF_CLUBS.observe(.value, with:  { snapshot in
            let clubCount = snapshot.childrenCount
            
            // Button displays the current league count
            self.clubCountBtn.text = clubCount.description
            
        }) { (error) in
            print(error.localizedDescription)
            print("CHET: local error")
        }
    }
}

