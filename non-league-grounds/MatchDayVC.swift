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


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = clubName
        print(clubName)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "StopWatchVC") {
            let destVC: StopWatchVC = segue.destination as! StopWatchVC
            destVC.clubName = clubName
        } else if (segue.identifier == "TeamSelection") {
            let destVC: TeamSelection = segue.destination as! TeamSelection
            destVC.clubName = clubName
        }
    }
}
