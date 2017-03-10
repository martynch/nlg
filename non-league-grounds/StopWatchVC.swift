//
//  StopWatchVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 08/02/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit
import Social

class StopWatchVC: UIViewController {

    
    var laps: [String] = []
    var halfTime: [String] = []
    var clubName = String ()
    var stopWatch = Stopwatch()
    var timer = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    
    var countDown = 45
    var countDownString: String = ""
    var stopWatchString: String = ""
    var startStopWatch: Bool = true
    var addLap: Bool = false
    
    @IBOutlet weak var more: UIButton!
    @IBOutlet weak var firstHalf: UIButton!
    @IBOutlet weak var secondHalf: UIButton!
    @IBOutlet weak var goal: UIButton!
    @IBOutlet weak var yellow: UIButton!
    @IBOutlet weak var secondYellow: UIButton!
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var sub: UIButton!
    @IBOutlet weak var extraTime: UIButton!
    @IBOutlet weak var endSecondHalf: UIButton!
    @IBOutlet weak var endFirstHalf: UIButton!
    @IBOutlet weak var tempTimelineLbl: UILabel!
    @IBOutlet weak var counterLbl: UILabel!
    
    @IBOutlet weak var stopwatchLabel: UILabel!


    var firstHalfButtonCenter: CGPoint!
    var secondHalfButtonCenter: CGPoint!
    var goalButtonCenter: CGPoint!
    var yellowCardButtonCenter: CGPoint!
    var secondYellowCardButtonCenter: CGPoint!
    var redCardButtonCenter: CGPoint!
    var subButtonCenter: CGPoint!
    var extraTimeButtonButtonCenter: CGPoint!
    var secondHalfEndedButtonCenter: CGPoint!
    var firstHalfEndedButtonCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstHalf.alpha = 0
        self.secondHalf.alpha = 0
        self.goal.alpha = 0
        self.yellow.alpha = 0
        self.secondYellow.alpha = 0
        self.red.alpha = 0
        self.sub.alpha = 0
        self.extraTime.alpha = 0
        self.endSecondHalf.alpha = 0
        self.endFirstHalf.alpha = 0

        firstHalfButtonCenter = firstHalf.center
        secondHalfButtonCenter = secondHalf.center
        goalButtonCenter = goal.center
        yellowCardButtonCenter = yellow.center
        secondYellowCardButtonCenter = secondYellow.center
        redCardButtonCenter = red.center
        subButtonCenter = sub.center
        extraTimeButtonButtonCenter = extraTime.center
        secondHalfEndedButtonCenter = endSecondHalf.center
        firstHalfEndedButtonCenter = endFirstHalf.center
        
        firstHalf.center = more.center
        secondHalf.center = more.center
        goal.center = more.center
        yellow.center = more.center
        secondYellow.center = more.center
        red.center = more.center
        sub.center = more.center
        extraTime.center = more.center
        endSecondHalf.center = more.center
        endFirstHalf.center = more.center
        
        stopwatchLabel.text = "0:00"
        counterLbl.text = "45:00"
    }
    
    @IBAction func menuClicked(_ sender: UIButton) {
        if more.currentImage == #imageLiteral(resourceName: "more_off") {
            UIView.animate(withDuration: 0.3, animations: {
                self.firstHalf.alpha = 1
                self.secondHalf.alpha = 1
                self.goal.alpha = 1
                self.yellow.alpha = 1
                self.secondYellow.alpha = 1
                self.red.alpha = 1
                self.sub.alpha = 1
                self.extraTime.alpha = 1
                self.endSecondHalf.alpha = 1
                self.endFirstHalf.alpha = 1
                
                self.firstHalf.center = self.firstHalfButtonCenter
                self.secondHalf.center = self.secondHalfButtonCenter
                self.goal.center = self.goalButtonCenter
                self.yellow.center = self.yellowCardButtonCenter
                self.secondYellow.center = self.secondYellowCardButtonCenter
                self.red.center = self.redCardButtonCenter
                self.sub.center = self.subButtonCenter
                self.extraTime.center = self.extraTimeButtonButtonCenter
                self.endSecondHalf.center = self.secondHalfEndedButtonCenter
                self.endFirstHalf.center = self.firstHalfEndedButtonCenter
                
//                if self.seconds > 1 && self.minutes < 10 {
//                    self.firstHalf.alpha = 0.2
//                    self.secondHalf.alpha = 0.2
//                    self.endFirstHalf.alpha = 0.2
//                    self.endSecondHalf.alpha = 0.2
//                } else {
//                    if self.minutes > 42 && self.minutes < 50 {
//                        self.firstHalf.alpha = 1
//                        self.secondHalf.alpha = 0.2
//                        self.endFirstHalf.alpha = 1
//                        self.endSecondHalf.alpha = 0.2
//                    }
//                }
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.firstHalf.alpha = 0
                self.secondHalf.alpha = 0
                self.goal.alpha = 0
                self.yellow.alpha = 0
                self.secondYellow.alpha = 0
                self.red.alpha = 0
                self.sub.alpha = 0
                self.extraTime.alpha = 0
                self.endSecondHalf.alpha = 0
                self.endFirstHalf.alpha = 0
    
                self.firstHalf.center = self.more.center
                self.secondHalf.center = self.more.center
                self.goal.center = self.more.center
                self.yellow.center = self.more.center
                self.secondYellow.center = self.more.center
                self.red.center = self.more.center
                self.sub.center = self.more.center
                self.extraTime.center = self.more.center
                self.endSecondHalf.center = self.more.center
                self.endFirstHalf.center = self.more.center
                
            })
        }
        
        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "more_on"), offImage: #imageLiteral(resourceName: "more_off"))
    }
    
    @IBAction func firstHalfClicked(_ sender: UIButton) {
        
        if startStopWatch == true {
            timerStart()
            startStopWatch = false
//            endFirstHalf.isEnabled = false
//            endSecondHalf.isEnabled = false
//            self.firstHalf.alpha = 0.2
//            self.secondHalf.alpha = 0.2
//            self.endFirstHalf.alpha = 0.2
//            self.endSecondHalf.alpha = 0.2
            seconds = 0
            minutes = 0

            
//            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//            vc?.setInitialText("\("Kick off here at")  \(clubName)")
//            vc?.add(#imageLiteral(resourceName: "start-1st"))
//            present(vc!, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func endFirstHalfClicked(_ sender: UIButton) {
        
        if startStopWatch == false {
//            endFirstHalf.isEnabled = true
            timer.invalidate()
            startStopWatch = true
            seconds = 0
            minutes = 45
            stopwatchLabel.text = "45:00"
//            self.secondHalf.alpha = 1
//            self.firstHalf.alpha = 0.2
//            self.endFirstHalf.alpha = 0.2
            
//            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//            vc?.setInitialText("Half Time")
//            vc?.add(#imageLiteral(resourceName: "end-1st"))
//            present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func secondHalfClicked(_ sender: UIButton) {
        
        if startStopWatch == true {
            timerStart()
            seconds = 0
            minutes = 45
//            endSecondHalf.isEnabled = false
//            endFirstHalf.isEnabled = false
//            self.secondHalf.alpha = 0.2
            startStopWatch = false
            tempTimelineLbl.text = "2nd Half Underway"
            
//            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//            vc?.setInitialText("2nd Half Underway")
//            vc?.add(#imageLiteral(resourceName: "start-2nd"))
//            present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func endSecondHalfClicked(_ sender: UIButton) {
        
        if startStopWatch == false {
//            endSecondHalf.isEnabled = true
//            self.endSecondHalf.alpha = 1
            timer.invalidate()
            startStopWatch = true
            seconds = 0
            minutes = 0
            stopwatchLabel.text = "90:00"
            tempTimelineLbl.text = "Full Time"
            
//            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//            vc?.setInitialText("Full Time")
//            vc?.add(#imageLiteral(resourceName: "end-2nd"))
//            present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func goalClicked(_ sender: UIButton) {
        
//        let stopWatchString = stopWatch.elapsedTimeSinceStart()
//        stopwatchLabel.text = stopWatchString
//        
//        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//        vc?.setInitialText("\(stopWatchString)'  \("Goal for") ")
//        vc?.add(#imageLiteral(resourceName: "goal"))
//        present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func yellowClicked(_ sender: UIButton) {
        
//        let stopWatchString = stopWatch.elapsedTimeSinceStart()
//        stopwatchLabel.text = stopWatchString
//        
//        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//        vc?.setInitialText("\(stopWatchString)'  \("Yellow Card for") ")
//        vc?.add(#imageLiteral(resourceName: "yellow"))
//        present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func secondBookableClicked(_ sender: UIButton) {
        
//        let stopWatchString = stopWatch.elapsedTimeSinceStart()
//        stopwatchLabel.text = stopWatchString
//        
//        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//        vc?.setInitialText("\(stopWatchString)'  \("Second Bookable for") ")
//        vc?.add(#imageLiteral(resourceName: "2nd-yellow"))
//        present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func redCardClicked(_ sender: UIButton) {
        
//        let stopWatchString = stopWatch.elapsedTimeSinceStart()
//        stopwatchLabel.text = stopWatchString
//        
//        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//        vc?.setInitialText("\(stopWatchString)'  \("Striaght Red for") ")
//        vc?.add(#imageLiteral(resourceName: "red"))
//        present(vc!, animated: true, completion: nil)
        
    }

    @IBAction func subClicked(_ sender: UIButton) {
        
//        let stopWatchString = stopWatch.elapsedTimeSinceStart()
//        stopwatchLabel.text = stopWatchString
//        
//        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//        vc?.setInitialText("\(stopWatchString)'  \("Substitution for") ")
//        vc?.add(#imageLiteral(resourceName: "sub"))
//        present(vc!, animated: true, completion: nil)
        
        tempTimelineLbl.text = "\(stopWatchString)'  \("Substitution for")"
    }
    
    func timerStart() {
        
        minutes = 45
        stopWatch.startTimer();
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(StopWatchVC.updateStopwatch), userInfo: nil, repeats: true)
    }
    
    func updateStopwatch() {
        
        let stopWatchString = stopWatch.elapsedTimeSinceStart()
        stopwatchLabel.text = stopWatchString
        
//        if minutes > 1 {
//            endFirstHalf.isEnabled = true
//            self.endFirstHalf.alpha = 1
//        }
//
//        if minutes > 87 {
//            endSecondHalf.isEnabled = true
//            self.endSecondHalf.alpha = 1
//        }
    }
    
    func updateCountDown() {
        
    }
    
    func toggleButton(button: UIButton, onImage: UIImage, offImage: UIImage) {
        if button.currentImage == offImage {
            button.setImage(onImage, for: .normal)
        } else {
            button.setImage(offImage, for: .normal)
        }
    }
}
