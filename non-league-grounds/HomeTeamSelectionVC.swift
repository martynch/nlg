//
//  HomeTeamSelectionVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/06/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase


protocol setSelectedPlayerProtocol {
    func setSelectedPlayer(selectedPlayer: String)
}


class HomeTeamSelectionVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var club: Clubs!
    var player = [Players]()
    var playerFirstName = String()
    var playerLastName = String()
    var playerSelected: Bool = false
    
    var delegate : setSelectedPlayerProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        CLUB_KEY = ""
        CLUB_KEY = club.clubKey
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
//        DataService.ds.REF_PLAYERS.queryOrdered(byChild: "clubKey").queryEqual(toValue: club.clubKey).observe(.value, with: { (snapshot) in
//            
//            print("PLAYERS_COUNT: \(snapshot.childrenCount)")
//            print("PLAYERS_SNAPSHOT: \(snapshot)")
//            
//            self.player = []
//            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
//                
//                for snap in snapshots {
//                    if let playerDict = snap.value as? Dictionary<String, AnyObject> {
//                        let key = snap.key
//                        
//                        let players = Players(playerKey: key, dictionary: playerDict)
//                        self.player.append(players)
//                        
//                    }
//                }
//            }
//            //            self.tableView.reloadData()
//        }) { (error) in
//            print(error.localizedDescription)
//            print("CHET: local error")
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return player.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let players = player[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTeamPlayersCell") as? HomeTeamPlayersCell {
            cell.configureCell(players)
            return cell
        } else {
            return HomeTeamPlayersCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let players: Players!
        players = player[indexPath.row]
        
        self.delegate.setSelectedPlayer(selectedPlayer: playerLastName)
        
        print (players.playerKey)
        print (players.playerFirstName)
        print (players.playerLastName)
        print(setSelectedPlayerProtocol.self)
        
        self.dismiss(animated: false) {
            // go back to MainMenuView as the eyes of the user
            self.presentingViewController?.dismiss(animated: false, completion: nil)
        }
    }
}
