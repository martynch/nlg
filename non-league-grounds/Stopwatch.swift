//
//  Stopwatch.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 02/03/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import Foundation

class Stopwatch {
    
    var startTime:Date?
    
    func startTimer() {
        startTime = Date();
    }
    
    func elapsedTimeSinceStart() -> String {
        var elapsed = 0.0;
        if let elapsedTime = startTime {
            if firstHalfTime {
                elapsed = elapsedTime.timeIntervalSinceNow
            } else {
               elapsed = elapsedTime.timeIntervalSinceNow - 45*60
            }
        }
        elapsed = -elapsed
        let minutes = Int(floor((elapsed / 60)));
        let seconds = Int(floor((elapsed.truncatingRemainder(dividingBy: 60))));
//        print(elapsed)
        let timeString = String(format: "%02d:%02d", minutes, seconds)
//        print(timeString)
        return timeString
    }
    
}
