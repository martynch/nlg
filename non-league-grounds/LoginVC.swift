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

class LoginVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var loginRegisterBtn: UIButton!
    @IBOutlet weak var loginRegisterSegment: UISegmentedControl!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginRegisterButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.isHidden = false
        handleSegmentControl()
        
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
    
    @IBAction func loginRegisterTapped(_ sender: UIButton) {
        
        if (loginRegisterSegment.selectedSegmentIndex == 1) {
            handleSegmentControl()
            handleRegister()
            print("LOGIN REGISTER TAPPED")
            
        } else {
            
            handleLogin()
            print("LOGIN REGISTER TAPPED")
        }
        
    }
    
    // Facebook Login Button
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unable to auth with facebook - \(error ?? "" as! Error)")
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
            } else if result?.isCancelled == true {
                
            } else {
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                Helper.helper.firebaseAuth(credential)
            }
            
            Helper.helper.showAlert(title: "Email in use, did you use another methond to register", msg: "please try again", controller: self)
        }
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
    

    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        
        handleSegmentControl()
    }
    
    func login(id: String, userData: Dictionary<String, String>) {
        
        if nameField.text != "" && emailField.text != "" && passwordField.text != "" {
            
        } else {
            
            Helper.helper.showAlert(title: "All fields are required", msg: "please try again", controller: self)
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print(error.localizedDescription)
            return
        }
        print(user.authentication)
        Helper.helper.loginWithGoogle(authentication: user.authentication)
    }
    
    func handleRegister() {
        
        self.nameField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        
        if let email = emailField.text, let pwd = passwordField.text {
            
            FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user: FIRUser?, error) in
                
                if error != nil {
                    
                    print (error.debugDescription)
                    
                    if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                        switch errCode {
                        case .errorCodeEmailAlreadyInUse:
                            Helper.helper.showAlert(title: "The email address is already in use", msg: "Did you register using another method below?", controller: self)
                        case .errorCodeWeakPassword:
                            Helper.helper.showAlert(title: "Weak Password", msg: "The password must be at least 6 characters long", controller: self)
                        case .errorCodeInvalidEmail:
                            Helper.helper.showAlert(title: "The email address is badly formatted", msg: "Please try again", controller: self)
                            break;
                        default:
                            print("DID NOT CATCH ANY FAULT")
                        }
                    }
                    
                } else {
                    print("Persisteded into FirDatabase")
                    if let user = user {
                        let userData = ["provider": user.providerID, "email": self.emailField.text ?? "Blank","username": self.nameField.text ?? "empty"] as [String : Any]
                        self.login(id: user.uid, userData: userData as! Dictionary<String, String>)
                        
                    }
                }
            })
        }
    }
    
    func handleLogin() {
        
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        
        if let email = emailField.text, let pwd = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user: FIRUser?, error) in
                
                if (error != nil) {
                    
                    print (error.debugDescription)
                    
                    if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                        switch errCode {
                        case .errorCodeWrongPassword:
                            Helper.helper.showAlert(title: "Incorrect password", msg: "Please try again", controller: self)
                            break;
                        case .errorCodeUserNotFound:
                            Helper.helper.showAlert(title: "Email address not found", msg: "Please try again or register", controller: self)
                            break;
                        case .errorCodeInvalidCredential:
                            break;
                        case .errorCodeInvalidEmail:
                            Helper.helper.showAlert(title: "The email address is badly formatted", msg: "Please try again", controller: self)
                            break;
                        default:
                            print("Didnt Catch THe Error Above")
                            print(error.debugDescription)
                        }
                    }
                }
                    
                else {
                    
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.login(id: user.uid, userData: userData)
                    }
                    print(error.debugDescription)
                }
            })
            
            self.nameField.text = ""
            self.emailField.text = ""
            self.passwordField.text = ""
        }
    }
    
    // Segment Controll
    func handleSegmentControl() {
        switch loginRegisterSegment.selectedSegmentIndex {
        case 0:
            loginRegisterButton.setTitle("Login", for: .normal)
            nameField.isHidden = true
            break;
        case 1:
            loginRegisterButton.setTitle("Register", for: .normal)
            nameField.isHidden = false
            break;
        default:
            loginRegisterButton.setTitle("Default", for: .normal)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.nameField {
            emailField.becomeFirstResponder()
            
        } else if textField == self.emailField {
            
            passwordField.becomeFirstResponder()
            self.view.becomeFirstResponder()
            
        } else if textField == self.passwordField {
            nameField.becomeFirstResponder()
            self.view.endEditing(true)
        }
        return true
    }
    
}
