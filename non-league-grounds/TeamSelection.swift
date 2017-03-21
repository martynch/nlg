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
    
//    var player: Players!
    var player = [Players]()
    var club: Clubs!
//    var club = [Clubs]()
    var clubName = String()
    var playerFirstName = String()
    var playerLastName = String()

    
    @IBOutlet var Player: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CLUB_KEY = ""
        CLUB_KEY = club.clubKey
        
        
        self.navigationItem.title = clubName
        
        DataService.ds.REF_PLAYERS.queryOrdered(byChild: "playerLastName").queryEqual(toValue: club.clubKey).observe(.value, with: { (snapshot) in
        
    
//        DataService.ds.REF_PLAYERS.queryOrdered(byChild: "playerLastName").observe(.value, with: { (snapshot) in
            
            self.player = []
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                print(snapshot)
                
//                print("PLAYERS: \(snapshot.key)")
                print("PLAYERS: \(self.player)")
                print("PLAYERS: \(self.playerLastName)")
                print("PLAYERS: \(self.player.count)")

                
                for snap in snapshot {
                    if let playerDict = snap.value as? Dictionary<String, Any> {
                        let key = snap.key
                        let players = Players(playerKey: key, dictionary: playerDict)
                        self.player.append(players)
                        
                        print(self.Player.count)
                    }
                }
            }
//            self.tableView.reloadData()
        })       
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
