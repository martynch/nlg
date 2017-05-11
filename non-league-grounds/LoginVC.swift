//
//  LoginVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 03/05/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import TwitterKit

class LoginVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var loginRegisterBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = "1066303110839-iis5am9f5rlnqtd0ggit11r426629gvu.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("CHET HERE")
        print(FIRAuth.auth()?.currentUser ?? "")
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth: FIRAuth, user: FIRUser?) in
            if user != nil {
                print(user ?? "")
                print("USER PRINTED ABOVE")
                Helper.helper.switchToRevealVC()
            } else {
                print("Unauthorised")
            }
        })
    }
    
    
    // Login Button Tapped
    @IBAction func signInTapped(_ sender: UIButton) {
        
        Helper.helper.login()
    }
    
    // Facebook Login Button
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unable to auth with facebook - \(error ?? "" as! Error)")
            } else if result?.isCancelled == true {
                print("User cancelled FB Auth")
            } else {
                print("Sucessfully authenticated with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                

                print("CHET: \(FBSDKAccessToken.current())")
                print(result?.token.tokenString ?? "")
    
                Helper.helper.firebaseAuth(credential)
                
            }
        }
        print("Facebook Login Tapped")
    }
    
    // Twitter Login Button
    @IBAction func twitterBtnTapped(_ sender: TWTRLogInButton) {
        Twitter.sharedInstance().logIn(completion: {session, error in
            
            print("Twitter Button Tapped")
            
            if (session != nil) {
                let authToken = session?.authToken
                let authTokenSecret = session?.authTokenSecret
                
                let credential = FIRTwitterAuthProvider.credential(withToken: authToken!, secret: authTokenSecret!)
                FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                    if error != nil {
                        print("First error")
                        print(error?.localizedDescription ?? "")
                        print(error.debugDescription)
                        return
                    }
                    
                    print("Logged in with twitter")
                    print(user?.displayName ?? "")
                    print(user?.uid ?? "")
                    print(user?.email ?? "")
                    Helper.helper.firebaseAuth(credential)
                    
                })
            } else {
                if error != nil {
                    print (error.debugDescription)
                    print(error?.localizedDescription ?? "")
                    return
                }
            }
        })
    }
    
    // Google Login Button
    @IBAction func goggleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
//    func twitterLogin(id: String, userData: Dictionary<String, String>) {
//        
//        let keychainResult = KeychainWrapper.defaultKeychainWrapper().setString(id, forKey: KEY_UID)
//        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
//        print("Data Saved to Keychain \(keychainResult)")
//        performSegue(withIdentifier: "goToFeed", sender: nil)
//        
//    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print(error.localizedDescription)
            return
        }
        print(user.authentication)
        Helper.helper.loginWithGoogle(authentication: user.authentication)
    }
}
