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
    
//    let reachability = Reachability()!
    
    
    @IBOutlet weak var leagueCountBtn: UILabel!
    @IBOutlet weak var clubCountBtn: UILabel!
    @IBOutlet weak var playersCountBtn: UILabel!
    @IBOutlet weak var burgerMenu: UIBarButtonItem!
    
    
    var league: Leagues!
    var clubs: Clubs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if currentReachabilityStatus == .notReachable {
            let titleColour: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = titleColour as? [String : Any]
            self.navigationItem.title = "NO INTERNET DETECTED"
            self.navigationController?.navigationBar.barTintColor = UIColor (red: 248.0/255, green: 8.0/255, blue: 8.0/255, alpha: 1.0)
            self.navigationController?.navigationBar.tintColor = UIColor.white
            
            Helper.helper.showAlert(title: "Not Internet Detected", msg: "Data Connectivity is Required", controller: self)
            
        } else {
            
            self.navigationItem.title = "Non-League Grounds"

        }
        
        burgerMenu.target = revealViewController()
        burgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
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
        
        DataService.ds.REF_PLAYERS.observe(.value, with:  { snapshot in
            let playerCount = snapshot.childrenCount
            self.playersCountBtn.text = playerCount.description
        }) { (error) in
            print(error.localizedDescription)
            print("CHET: local error")
        }
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        
        FirebaseManager.signOut()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FirebaseManager.didLinkToProvider, let info = FirebaseManager.loginInfo {
            
            FirebaseManager.login(email: info.email, password: info.password, completion: { (status: Bool, error:Error?) in
                
                if status {
                    
                    DispatchQueue.main.async {
                        self.handleEmailStatus()
                    }
                }
                
            })
        } else {
            
            if FirebaseManager.isLoggedIn == false {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let LoginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC2") as! LoginViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = LoginVC
            }
        }
    }
    
    func handleEmailStatus() {
        
    }
}


