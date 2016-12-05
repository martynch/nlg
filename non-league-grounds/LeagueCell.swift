//
//  LeagueCell.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit

class LeagueCell: UITableViewCell {
    
    @IBOutlet weak var leagueLbl: UILabel!
    
    var league: Leagues!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(_ league: Leagues) {
        self.league = league
        
        self.leagueLbl.text = league.leagueKey
        
    }
    
}
