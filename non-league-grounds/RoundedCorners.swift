//
//  RoundedCorners.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 15/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit

class RoundedCorners: UIImageView {
    
    override func awakeFromNib() {
        layer.cornerRadius = 30.0
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
    }
}
