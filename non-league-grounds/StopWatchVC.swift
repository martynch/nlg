//
//  StopWatchVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 08/02/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit
import Social

class StopWatchVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var event: [Any] = []
    var time: [String] = []
    var halfTime: [String] = []
    var clubName = String ()
    var stopWatch = Stopwatch()
    var timer = Timer()
    
    var countDown = 2700
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
    @IBOutlet weak var homeScoreLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var coundDownLabel: UILabel!


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
        
        // Marcos Navigation Bar Translucent
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
        
        // Marcos Font in Nav Bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Arial", size: 21)!]
        //self.navigationItem.title = "(teamOne)vs(teamTwo)"
        
        print(clubName)
        
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
        
        stopwatchLabel.text = "00:00"
        coundDownLabel.text = "45:00"

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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StopwatchCell
//        cell.homePlayerLabel?.text = time[indexPath.row]
        cell.homeEventImage.image = event[indexPath.row] as? UIImage
        cell.eventTimeLabel.text = time[indexPath.row]
        cell.backgroundColor = UIColor.clear

//        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
//        cell.textLabel?.text = event[indexPath.row]
//        cell.detailTextLabel?.text = time[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return time.count
    }
    
    
    @IBAction func firstHalfClicked(_ sender: UIButton) {
        
        if startStopWatch == true {
            timerStart()
            firstHalfTime = true
            startStopWatch = false
            firstHalf.isEnabled = false
            secondHalf.isEnabled = false
            endSecondHalf.isEnabled = false
            
            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            vc?.setInitialText("\("Kick off here at")  \(clubName)")
//            vc?.add(#imageLiteral(resourceName: "start-1st"))
            present(vc!, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func endFirstHalfClicked(_ sender: UIButton) {
        
        if startStopWatch == false {
            timer.invalidate()
            startStopWatch = true
            secondHalf.isEnabled = true
            endFirstHalf.isEnabled = false
            stopwatchLabel.text = "45:00"
            
            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            vc?.setInitialText("Half Time")
//            vc?.add(#imageLiteral(resourceName: "end-1st"))
            present(vc!, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func secondHalfClicked(_ sender: UIButton) {
        
        if startStopWatch == true {
            timerStart()
            firstHalfTime = false
            secondHalf.isEnabled = false
            endSecondHalf.isEnabled = true
            firstHalf.isEnabled = false
            endFirstHalf.isEnabled = false
            startStopWatch = false
            
            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            vc?.setInitialText("2nd Half Underway")
//            vc?.add(#imageLiteral(resourceName: "start-2nd"))
            present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func endSecondHalfClicked(_ sender: UIButton) {
        
        if startStopWatch == false {
            firstHalf.isEnabled = true
            endSecondHalf.isEnabled = true
            timer.invalidate()
            startStopWatch = true
            stopwatchLabel.text = "90:00"

            
            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            vc?.setInitialText("Full Time")
//            vc?.add(#imageLiteral(resourceName: "end-2nd"))
            present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func goalClicked(_ sender: UIButton) {
        
        let stopWatchString = stopWatch.elapsedTimeSinceStart()
        stopwatchLabel.text = stopWatchString
        
    
        event.insert(#imageLiteral(resourceName: "goal"), at: 0)
        time.insert(stopWatchString, at: 0)
        print(time)
        self.tableView.reloadData()
        
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        vc?.setInitialText("\(stopWatchString)'  \("Goal for") ")
//        vc?.add(#imageLiteral(resourceName: "goal"))
        present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func yellowClicked(_ sender: UIButton) {
        
        let stopWatchString = stopWatch.elapsedTimeSinceStart()
        stopwatchLabel.text = stopWatchString
        
        time.insert(stopWatchString, at: 0)
        event.insert(#imageLiteral(resourceName: "yellow"), at: 0)
        self.tableView.reloadData()
        
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        vc?.setInitialText("\(stopWatchString)'  \("Yellow Card for") ")
//        vc?.add(#imageLiteral(resourceName: "refYellow"))
        present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func secondBookableClicked(_ sender: UIButton) {
        
        let stopWatchString = stopWatch.elapsedTimeSinceStart()
        time.insert(stopWatchString, at: 0)
        event.insert(#imageLiteral(resourceName: "2nd-yellow"), at: 0)
        self.tableView.reloadData()
        
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        vc?.setInitialText("\(stopWatchString)'  \("Second Bookable for") ")
//        vc?.add(#imageLiteral(resourceName: "ref2ndbookable"))
        present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func redCardClicked(_ sender: UIButton) {
        
        let stopWatchString = stopWatch.elapsedTimeSinceStart()
        time.insert(stopWatchString, at: 0)
        event.insert(#imageLiteral(resourceName: "red"), at: 0)
        tableView.reloadData()
        
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        vc?.setInitialText("\(stopWatchString)'  \("Striaght Red for") ")
//        vc?.add(#imageLiteral(resourceName: "refRed"))
        present(vc!, animated: true, completion: nil)
        
    }

    @IBAction func subClicked(_ sender: UIButton) {
        
        let stopWatchString = stopWatch.elapsedTimeSinceStart()
        time.insert(stopWatchString, at: 0)
        event.insert(#imageLiteral(resourceName: "sub"), at: 0)
        tableView.reloadData()
        
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        vc?.setInitialText("\(stopWatchString)'  \("Substitution for") ")
//        vc?.add(#imageLiteral(resourceName: "refSubstitution")) 
        present(vc!, animated: true, completion: nil)
        
    }
    
    func timerStart() {
        
        stopWatch.startTimer();
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateStopwatch), userInfo: nil, repeats: true)
        
    }
    
    func updateStopwatch() {
        
        let stopWatchString = stopWatch.elapsedTimeSinceStart()
        stopwatchLabel.text = stopWatchString
        
     }
    
    func updateCountDown() {
        
//        if (countDown > 0) {
//            let minutes = String(countDown / 60)
//            let seconds = String(countDown % 60)
//            coundDownLabel.text = minutes + ":" + seconds
//            countDown -= 1
//        }
    }
    
    func toggleButton(button: UIButton, onImage: UIImage, offImage: UIImage) {
        if button.currentImage == offImage {
            button.setImage(onImage, for: .normal)
        } else {
            button.setImage(offImage, for: .normal)
        }
    }
}
