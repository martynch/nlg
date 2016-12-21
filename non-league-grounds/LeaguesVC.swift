//
//  LeaguesVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase

class LeaguesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var leagues = [Leagues]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "LEAGUES"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        DataService.ds.REF_LEAGUES.queryOrdered(byChild: "leagueName").observe(.value, with: { (snapshot) in


            self.leagues = []
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshot {
                    if let leagueDict = snap.value as? Dictionary<String, Any> {
                        let key = snap.key
                        let league = Leagues(leagueKey: key, dictionary: leagueDict)
                        self.leagues.append(league)
                    }
                }
            }
            
            self.tableView.reloadData()
        }) 
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let league = leagues[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell") as? LeagueCell {
            
            cell.configureCell(league)
            return cell
        } else {
            return LeagueCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let league: Leagues!
        league = leagues[indexPath.row]
        performSegue(withIdentifier: "ClubsVC", sender: league) // To Destination from Here
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ClubsVC" { // To Destination VS
            if let detailVC = segue.destination as? ClubsVC { // To Destination fro Here
                if let league = sender as? Leagues { //
                    detailVC.league = league
                }
            }
        }
    }
}
