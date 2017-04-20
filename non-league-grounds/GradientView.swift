//
//  GradientView.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 07/04/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var FirstColour: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var SecondColour: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [ FirstColour.cgColor, SecondColour.cgColor ]
        layer.locations = [ 0.5 ]
    }
}
