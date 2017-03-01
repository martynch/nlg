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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
