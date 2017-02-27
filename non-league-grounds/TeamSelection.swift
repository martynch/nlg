//
//  TeamSelection.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 02/02/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit

class TeamSelection: UIViewController {
    
    @IBOutlet var Player: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

class DraggableView: UIView {
    
    private var originalCenter: CGPoint?
    private var dragStart: CGPoint?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        originalCenter = center
        dragStart = touches.first?.location(in: superview)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: superview)
        if let predicted = event?.predictedTouches(for: touch)?.last {
            location = predicted.location(in: superview)
        }
        center = dragStart! + location - originalCenter!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: superview)
        center = dragStart! + location - originalCenter!
    }
}

extension CGPoint {
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
