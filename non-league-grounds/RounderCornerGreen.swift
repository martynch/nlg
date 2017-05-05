//
//  RounderCornerGreen.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 25/04/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit

class RounderCornerGreen: UIImageView {
    
    override func awakeFromNib() {
        layer.cornerRadius = 15.0
        layer.borderColor = UIColor (red:27.0/255.0, green:132.0/255.0, blue:104.0/255, alpha: 1).cgColor
        layer.borderWidth = 2
    }
}
