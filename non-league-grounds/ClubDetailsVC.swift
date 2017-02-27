//
//  ClubDetailsVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase
import UIKit
import MessageUI

class ClubDetailsVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    var clubs = [Clubs]()
        
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var groundLbl: UILabel!
    @IBOutlet weak var chairmanLbl: UILabel!
    @IBOutlet weak var address1Lbl: UILabel!
    @IBOutlet weak var address2Lbl: UILabel!
    @IBOutlet weak var address3Lbl: UILabel!
    @IBOutlet weak var address4Lbl: UILabel!
    @IBOutlet weak var postCodeLbl: UILabel!
    @IBOutlet weak var clubCrest: UIImageView!
    var club: Clubs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.title = club.clubName
        
        groundLbl.text = club.groundName
        chairmanLbl.text = club.chairman
        address1Lbl.text = club.address1
        address2Lbl.text = club.address2
        address3Lbl.text = club.address3
        address4Lbl.text = club.address4
        postCodeLbl.text = club.postCode
        
        let url = NSURL(string: club.crest)
        clubCrest.sd_setImage(with: url as URL!, placeholderImage: #imageLiteral(resourceName: "logo"))
        
    }
    
    @IBAction func fbBtn(_ sender: Any) {
        
        let fbUrlWeb: URL = URL(string: "https://www.facebook.com/groups/\(club.facebook)")!
        let fbUrlID: URL = URL(string: "fb://profile/\(club.facebook)")!
        
        if (UIApplication.shared.canOpenURL(fbUrlID)) {
            UIApplication.shared.open(fbUrlID, options: [:], completionHandler: {
                (Sucess) in
            })
        } else {
            UIApplication.shared.open(fbUrlWeb, options: [:], completionHandler: {
                (Sucess) in
            })
        }
    }
    
    @IBAction func twtBtn(_ sender: Any) {

        let twUrl: URL = URL(string: "twitter://user?screen_name=\(club.twitter)")!
        let twUrlWeb: URL = URL(string: "https://twitter.com/\(club.twitter)")!
        
        if (UIApplication.shared.canOpenURL(twUrl)) {
            UIApplication.shared.open(twUrl, options: [:], completionHandler: {
                (Sucess) in
            })
        } else {
            UIApplication.shared.open(twUrlWeb, options: [:], completionHandler: {
                (Sucess) in
            })
        }
    }
    
    @IBAction func webBtn(_ sender: Any) {
        
        web(scheme: club.webUrl)
    }
    
    @IBAction func mailBtn(_ sender: Any) {
        
        sendmail()
    }
    
    @IBAction func teamBtn(_ sender: Any) {
        
    }
    
    @IBAction func mapBtn(_ sender: Any) {
        
        print("map")
    }
    
    func web(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],completionHandler: {
                    (success) in
                    print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }
    
    func sendmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([club.email])
            mail.setSubject("")
            mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true, completion: nil)
            
        } else {
            
            print("Error")
        }
    }
    
    func showAlert(_ title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "MatchDayVC") {
            
            let destVC :MatchDayVC = segue.destination as! MatchDayVC
            destVC.clubName = club.clubName
            
        } else if (segue.identifier == "ClubLocationVC") {
            
            let destVC :ClubLocationVC = segue.destination as! ClubLocationVC
            
            destVC.pinTitle = club.clubName
            destVC.pinSubTitle = club.groundName
            destVC.latitude = club.latitude
            destVC.longitude = Double(club.longitude)
            
        }
    }
}
