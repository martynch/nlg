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
    @IBOutlet weak var divisionLbl: UILabel!
    
    var division: Divisions!
    var clubs = [Clubs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DIVISION_KEY = ""
        DIVISION_KEY = division.divisionKey
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        let REF_CHOSEN_DIVISION = Firebase(url: "\(URL_BASE)/Leagues/\(LEAGUE_KEY)/\(division.divisionKey)/Club/")
        divisionLbl.text = division.divisionKey
        
        //        print (division.divisionKey)
        
        // need to query by assending order
//        REF_CHOSEN_DIVISION?.queryOrderedByValue().observe(.value, with: { snapshot in
//            
//            //        print("SNAP KEY: \(snapshot.key)")
//            //        print("SNAP VALUE: \(snapshot.value)")
//            
//            
//            self.clubs = []
//            if let snapshots = snapshot?.children.allObjects as? [FDataSnapshot] {
//                
//                for snap in snapshots {
//                    //                print("CLUB: \(snap)")
//                    
//                    if let clubDict = snap.value as? Dictionary<String, AnyObject> {
//                        let key = snap.key
//                        let clubs = Clubs(clubKey: key!, dictionary: clubDict)
//                        self.clubs.append(clubs)
//                    }
//                }
//            }
//            
//            self.tableView.reloadData()
//            
//        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let club = clubs[indexPath.row]
        //        print(club.clubName)
        
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
        
        //        print(club.clubName)
        
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
