//
//  ClubDetailsVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase

class ClubDetailsVC: UIViewController {
    
    
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var groundLbl: UILabel!
    @IBOutlet weak var chairmanLbl: UILabel!
    @IBOutlet weak var address1Lbl: UILabel!
    @IBOutlet weak var address2Lbl: UILabel!
    @IBOutlet weak var address3Lbl: UILabel!
    @IBOutlet weak var address4Lbl: UILabel!
    @IBOutlet weak var postCodeLbl: UILabel!
    
    var club: Clubs!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        clubLbl.text = club.clubName
        groundLbl.text = club.groundName
        chairmanLbl.text = club.chairman
        address1Lbl.text = club.address1
        address2Lbl.text = club.address2
        address3Lbl.text = club.address3
        address4Lbl.text = club.address4
        postCodeLbl.text = club.postCode
        
    }
    
}
