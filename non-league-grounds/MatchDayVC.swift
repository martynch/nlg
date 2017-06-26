//
//  MatchDayVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 06/02/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit

class MatchDayVC: UIViewController {
    
    var clubName = String ()
    var club: Clubs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Marcos Navigation Bar Translucent
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
        
        // Marcos Font in Nav Bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Arial", size: 21)!]
        self.navigationItem.title = "Team Selection"

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "StopWatchVC") {
            let destVC: StopWatchVC = segue.destination as! StopWatchVC
            destVC.clubName = clubName
            
        } else if (segue.identifier == "HomeTeamSelectionVC") {
            let destVC: HomeTeamSelectionVC = segue.destination as! HomeTeamSelectionVC
            destVC.club = club
        }
    }
}
