//
//  StopwatchCell.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 11/04/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit

class StopwatchCell: UITableViewCell {
    
    
    @IBOutlet weak var homePlayerLabel: UILabel!
    @IBOutlet weak var homeEventImage: UIImageView!
    @IBOutlet weak var eventTimeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
        circle.center = self.center
        circle.layer.cornerRadius = 20
        circle.layer.backgroundColor = UIColor (red:27.0/255.0, green:132.0/255.0, blue:104.0/255, alpha: 1).cgColor
        circle.clipsToBounds = true
        self.insertSubview(circle, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
