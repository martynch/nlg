//
//  Helper.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 05/05/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth
import FBSDKLoginKit
import TwitterKit


class Helper {
    static let helper = Helper()
    
    func login() {
        
        FIRAuth.auth()?.signInAnonymously(completion: { (anonymousUser: FIRUser?, error) in
            if error == nil {
                print("UserID: \(anonymousUser!.uid)")
                self.switchToRevealVC()
            } else {
                print(error!.localizedDescription)
                return
            }
        })
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                
                print(error!.localizedDescription)
                print (error.debugDescription)
                
                if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .errorCodeEmailAlreadyInUse:
                        break;
                    case .errorCodeWeakPassword:
                        break;

                    default:
                        print("DID NOT CATCH ANY FAULT")
                    }
                }
                
            } else {
                self.switchToRevealVC()
                print("Sucessfully logged in")
                
            }
        })
    }
    
    func loginWithGoogle(authentication: GIDAuthentication) {
        
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user: FIRUser?, error: Error?) in
            if error != nil {
                print(error?.localizedDescription ?? "")
//                showAlert(title: "Email in use, did you use another method to register", msg: "please try again", controller: self)
            }else {
                print(user?.email ?? "")
                print(user?.displayName ?? "")
                self.switchToRevealVC()
            }
        })
    }
    
    func showAlert(title: String, msg: String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func switchToRevealVC(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier: "ReavealVC") as! SWRevealViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
    }
}

extension UIViewController {
    
    func showExtensionAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
