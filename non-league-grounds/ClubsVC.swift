//
//  ClubsVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase

class ClubsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leagueLbl: UILabel!
    
    var league: Leagues!
    var clubs = [Clubs]()
    var players = [Players]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LEAGUE_KEY = ""
        LEAGUE_KEY = league.leagueKey
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        leagueLbl.text = league.leagueName
        
        self.navigationItem.title = league.leagueName
        
        
        DataService.ds.REF_CLUBS.queryOrdered(byChild: "leagueKey").queryEqual(toValue: league.leagueKey).observe(.value, with: { (snapshot) in
            
            self.clubs = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                print(snapshot.key)
                
                for snap in snapshots {
                    if let clubDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
        
                        let clubs = Clubs(clubKey: key, dictionary: clubDict)
                        self.clubs.append(clubs)
                    } 
                }
            }
            
            self.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
            print("CHET: local error")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let club = clubs[indexPath.row]        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell") as? ClubCell {
            cell.configureCell(club)
            return cell
        } else {
            return ClubCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let club: Clubs!
        club = clubs[indexPath.row]
        performSegue(withIdentifier: "ClubDetailsVC", sender: club) // To Destination from Here
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? ClubDetailsVC { // To Destination from Here
            if let club = sender as? Clubs { // sender Class
                detailVC.club = club
            }
        }
    }
}
