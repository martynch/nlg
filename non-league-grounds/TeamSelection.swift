//
//  TeamSelection.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 02/02/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase

class TeamSelection: UIViewController, setSelectedPlayerProtocol {
    
    func setSelectedPlayer(selectedPlayer: String) {
        
    }

    
    //IBOutlets Collection for Player Names
    @IBOutlet var playerButtons: [UIButton]!
    
    //Single IBOulet
    @IBOutlet weak var singlePlayerButton: UIButton!
    
    
    // IBOutlet Lables
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    
//    @IBOutlet var Player: [UIView]!
    
    
    var player = [Players]()
    var club: Clubs!
    var clubName = String()
    var playerFirstName = String()
    var playerLastName = String()
    
    
    
    
//    var playersT1ArrayFromFB : [Dictionary<String,String>] = []
    
    var delegate : setSelectedPlayerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for i in 0...playersT1ArrayFromFB.count - 1 {
//            
//
//        }
//        arrayForSmallVC.append("(playersT1ArryFromFB.playerFirstName ) (playersT1ArrayFromFB.playerLastName)"
        
        
        
        CLUB_KEY = ""
        CLUB_KEY = club.clubKey
        
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
        
        let senderINT = sender.tag
        
        let selectedBtn = self.view.viewWithTag(senderINT) as! UIButton
        
        selectedBtn.setTitle(playerLastName, for: .normal)
        
//        self.delegate.setSelectedPlayer(selectedPlayer: playerLastName)
        
         self.performSegue(withIdentifier: "HomeTeamSelectionVC", sender: self)
        
        print(sender)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "HomeTeamSelectionVC") {
            let destVC :HomeTeamSelectionVC = segue.destination as! HomeTeamSelectionVC
            destVC.club = club
        }
    }
}
