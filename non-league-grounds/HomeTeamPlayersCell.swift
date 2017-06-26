//
//  HomeTeamPlayersCell.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/06/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit

class HomeTeamPlayersCell: UITableViewCell {
    
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var player: Players!
    
    func configureCell(_ player: Players) {
        self.firstNameLabel.text = player.playerFirstName
        self.lastNameLabel.text = player.playerLastName
    }
}
