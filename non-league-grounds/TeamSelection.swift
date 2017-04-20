//
//  TeamSelection.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 02/02/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase


class TeamSelection: UIViewController {
    
    var player = [Players]()
    var club: Clubs!
    var clubName = String()
    var playerFirstName = String()
    var playerLastName = String()

    
    @IBOutlet var Player: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CLUB_KEY = ""
        CLUB_KEY = club.clubKey
        
        
        self.navigationItem.title = club.clubName
        
        DataService.ds.REF_PLAYERS.queryOrdered(byChild: "clubKey").queryEqual(toValue: club.clubKey).observe(.value, with: { (snapshot) in
        
            print("PLAYERS_COUNT: \(snapshot.childrenCount)")
            print("PLAYERS_SNAPSHOT: \(snapshot)")
            
            self.player = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    if let playerDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        
                        let players = Players(playerKey: key, dictionary: playerDict)
                        self.player.append(players)
                        
                    }
                }
            }
//            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
            print("CHET: local error")
        }
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
