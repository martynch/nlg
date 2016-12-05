//
//  DivisionsVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase

class DivisionsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var divisionLbl: UILabel!
    @IBOutlet weak var testLbl: UILabel!
    
    var league: Leagues!
    var divisions = [Divisions]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LEAGUE_KEY = ""
        LEAGUE_KEY = league.leagueKey
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        let REF_CHOSEN_LEAGUE = Firebase(url: "\(URL_BASE)/Leagues/\(league.leagueKey)")
        testLbl.text = league.leagueKey
        
        //        print(league.leagueKey)
        
//        REF_CHOSEN_LEAGUE?.queryOrderedByValue().observe(.value, with: { snapshot in
//            
//            //        print("Division: \(snapshot.childrenCount)")
//            //        print("DIVISION: \(snapshot.value)")
//            
//            
//            self.divisions = []
//            if let snapshots = snapshot?.children.allObjects as? [FDataSnapshot] {
//                
//                for snap in snapshots {
//                    //                    print("DIVISION: \(snap)")
//                    
//                    if let divisionDict = snap.value as? Dictionary<String, AnyObject> {
//                        let key = snap.key
//                        let division = Divisions(divisionKey: key!, dictionary: divisionDict)
//                        self.divisions.append(division)
//                    }
//                }
//            }
//            
//            self.tableView.reloadData()
//            
//        })
//        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return divisions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let division = divisions[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DivisionCell") as? DivisionCell {
            
            cell.configureCell(division)
            return cell
        } else {
            return DivisionCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let division: Divisions!
        
        division = divisions[indexPath.row]
        
        //        print(league.leagueKey)
        
        performSegue(withIdentifier: "ClubsVC", sender: division) // To Destination from Here
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClubsVC" { // To Destination VS
            if let detailVC = segue.destination as? ClubsVC {
                if let division = sender as? Divisions {
                    detailVC.division = division
                }
                
            }
        }
    }
    
}
