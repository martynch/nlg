//
//  ClubCell.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit

class ClubCell: UITableViewCell {

    @IBOutlet weak var clubLbl: UILabel!
    
    var club: Clubs!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(_ club: Clubs) {
        self.club = club
        
        self.clubLbl.text = club.clubName
        
        print("Did we get to ClubCell")
        print(club.clubName)
        print(club.clubKey)
        
    }
}

