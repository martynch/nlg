//
//  burgerVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 23/12/2016.
//  Copyright © 2016 Martyn Cheatle. All rights reserved.
//

import UIKit
import MessageUI

class burgerVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate  {

    var menuNameArray:Array = [String]()
    var menuImage:Array = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuNameArray = ["Facebook","Twitter","Feedback and Support", "Bug Report"]
        menuImage = [UIImage(named: "support-facebook")!,UIImage(named: "support-twitter")!,UIImage(named: "support-email")!,UIImage(named: "bug-report")!]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BurgerCell") as? BurgerCell
        cell?.burgerImg.image = menuImage[indexPath.row]
        cell?.burgerLbl.text! = menuNameArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:BurgerCell = (tableView.cellForRow(at: indexPath) as? BurgerCell)!
        
        if cell.burgerLbl.text == "Feedback and Support"
        {
            sendmail()
        }
        if cell.burgerLbl.text == "Facebook"
        {
            let fbUrlWeb: URL = URL(string: "https://www.facebook.com/nonleaguegrounds")!
            let fbUrlID: URL = URL(string: "fb://profile/368025750223986")!
            
            // If user has has Facebook installed
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
        if cell.burgerLbl.text == "Twitter"
            
        {
            let twUrl: URL = URL(string: "twitter://user?screen_name=nonleague_uk")!
            let twUrlWeb: URL = URL(string: "https://twitter.com/nonleague_uk")!
            
            // If user has has Facebook installed
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
        if cell.burgerLbl.text == "Bug Report"
        {
            bugReport(scheme: "http://www.nonleaguescores.com/bugtracker")
        }
    }
    
    func sendmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@nonleaguescores.com"])
            mail.setSubject("Feedback - Bug Report")
            mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true, completion: nil)
            
        } else {
            
            print("Error")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func showAlert(_ title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
     func bugReport(scheme: String) {
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
}
