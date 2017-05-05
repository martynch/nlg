//
//  TeamSelection.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 02/02/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase


class TeamSelection: UIViewController {
    
    //IBOutlets Collection for Player Names
    @IBOutlet var playerButtons: [UIButton]!
    
    
    var player = [Players]()
    var club: Clubs!
    var clubName = String()
    var playerFirstName = String()
    var playerLastName = String()

    
    @IBOutlet var Player: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CLUB_KEY = ""
        CLUB_KEY = club.clubKey
        
        self.navigationItem.title = club.clubName
        
        DataService.ds.REF_PLAYERS.queryOrdered(byChild: "clubKey").queryEqual(toValue: club.clubKey).observe(.value, with: { (snapshot) in
        
            print("PLAYERS_COUNT: \(snapshot.childrenCount)")
            print("PLAYERS_SNAPSHOT: \(snapshot)")
            
            self.player = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    if let playerDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        
                        let players = Players(playerKey: key, dictionary: playerDict)
                        self.player.append(players)
                        
                    }
                }
            }
//            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
            print("CHET: local error")
        }
    }
    
    //IBActions Collection for Player Names
    @IBAction func playerSelectionAction(_ sender: UIButton) {
        
        let sender = sender.tag
        print(sender)
        
    }    
}
