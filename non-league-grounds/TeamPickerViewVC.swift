//
//  TeamPickerViewVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 02/05/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit

class TeamPickerViewVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var pickerView: UIPickerView!
    
    var teamselection: TeamSelection!
//    var players = [Players]()
    var players = ["player 1", "player 2", "player 3", "and so on"]

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return players.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        return players[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//        titleLbl.text = players[row]
        
    }
}
