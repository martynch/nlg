//
//  BurgerCell.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 23/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit

class BurgerCell: UITableViewCell {

    @IBOutlet weak var burgerImg: UIImageView!
    @IBOutlet weak var burgerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
