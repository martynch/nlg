//
//  DivisionCell.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit

class DivisionCell: UITableViewCell {

    @IBOutlet weak var divisionLbl: UILabel!
    
    var division: Divisions!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(_ division: Divisions) {
        self.division = division
        
        self.divisionLbl.text = division.divisionKey
        
    }
}

