//
//  FirebaseManager.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 16/05/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import Foundation
import Firebase

struct LoginInfo {
    var email:String
    var password:String
    
    init(email:String, password:String) {
        self.email = email
        self.password = password
        
    }
    
    init (dictionary:[String:String]?) {
        
        if dictionary == nil {
            self.email = ""
            self.password = ""
            return
        }
        
        self.email = dictionary!["email"]!
        self.password = dictionary!["password"]!
    }
    
    var dictionary:[String:String] {
        
        return ["email":self.email, "password":self.password]
        
    }
}

class FirebaseManager {
    
    static var isEmailVerified = false
    
    static func setup() {
        
        // This listner will trugger whenever the state of authentication changes
        // We will use it to track the email varification
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth:FIRAuth, user:FIRUser?) in
            
            if let user = user, user.isEmailVerified && didLinkToProvider {
                
                self.isEmailVerified = true
                
            } else if let user = user, !user.isEmailVerified && didLinkToProvider {
                
                self.isEmailVerified = false
                
            } else {
                print ("User not authenticated")
            }
            
        })
        
        // If we are already using credentials account we dont need to sign in as anonymous anymore
        if didLinkToProvider {
            return
        }
        
        // This will create a new anonymous user or sign if one already created
        FIRAuth.auth()?.signInAnonymously(completion: { (anonymousUser: FIRUser?, error:Error?) in
            if error == nil && anonymousUser != nil {
                print("Anonymous user signed in")
                print("UserID: \(anonymousUser!.uid)")
//                Helper.helper.switchToRevealVC()
    
            } else {
                print("Error singing anonymous user in")
                print(error!.localizedDescription)
            }
        })
    }
    
    //Store User Logon Info for auto sign in next time
    static var loginInfo:LoginInfo? {
        
        set {
            
            UserDefaults.standard.set(newValue?.dictionary, forKey: "loginInfoKey")
        }
        
        get {
            
            return LoginInfo.init(dictionary: UserDefaults.standard.dictionary(forKey: "loginInfoKey") as? [String:String])
        }
        
    }
    
    // Flag to tell us if we have linked our user or not
    static var didLinkToProvider:Bool {
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: "didLinkToProviderKey")
            
        }
        
        get {
            
            return UserDefaults.standard.bool(forKey: "didLinkToProviderKey")
            
        }
    }
    
    // We need a local variable to tell us if we are logged in ot not to use it later
    static var isLoggedIn = false
    
    //This function will link current anonymous user to email and password
    //This will be called the first time the user signs in
    
    static func LinkWithEmailAndPassword(email:String, password:String, completion:@escaping (_ status:Bool, _ error:Error?)->Void) {
        
        let credential = FIREmailPasswordAuthProvider.credential(withEmail: email, password: password)
        
        FIRAuth.auth()?.currentUser?.link(with: credential, completion: { (user:FIRUser?, error:Error?) in
            
            if error == nil, user != nil {
                
                // Now we need to send the user a vareification email once they are signed in with email and password for the first time
                user?.sendEmailVerification(completion: { (error:Error?) in
                    
                    if error == nil {
                        print("Did send verification email")
                    }
                })
                
                //Save the login info once we link the email to user and account
                self.loginInfo = LoginInfo.init(email: email, password: password)
                
                self.didLinkToProvider = true
                
                //Since this function will return a signed in user with a new link
                self.isLoggedIn = true
                
                completion(true, nil)
                
            } else {
                completion(false, error)
            }
        })
    }
    
    // Login Fuction
    static func login(email:String, password:String, completion: @escaping (_ status:Bool, _ error: Error?)->Void) {
        
        let credential = FIREmailPasswordAuthProvider.credential(withEmail: email, password: password)
        FIRAuth.auth()?.signIn(with: credential, completion: { (user:FIRUser?, error:Error?) in
            
            if let _ = user {
                
                if self.didLinkToProvider == false{
                    // We also need to save the LoginInfo we sign in here in case the user installed the app and already created an account in the past
                    self.loginInfo = LoginInfo.init(email: email, password: password)
                    self.didLinkToProvider = true
                }
                
                self.isLoggedIn = true
                completion(true, nil)
                
            } else {
                
                completion(false, error)
            }
            
        })
    }
    
    // Sign out from the account and dont auto sign in again
    static func signOut() {
        
        self.loginInfo = nil
//        try? FIRAuth.auth()?.signOut()
    
        do {
            try FIRAuth.auth()?.signOut()

        } catch let error {
            print(error.localizedDescription)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC2") as! LoginViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = LoginVC
        
    }
    
    // send email to the specified email
    static func sendPasswordReset(email:String,completion:@escaping (_ Status: Bool)-> Void){
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error:Error?) in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    // Handle Firebase errors
    static func StringFromError(error:Error?)->String {
        
        guard let firebaseError = error as NSError? else {
            return ""
        }
        
        if let errorCode = FIRAuthErrorCode(rawValue: firebaseError.code) {
            
            switch errorCode {
            case .errorCodeInvalidEmail:
                return "Email is not Valid"
                
            case .errorCodeUserNotFound:
                return "There is no account associated with this email address, Please sign up!"
                
            case .errorCodeWrongPassword:
                return "Password is not correct, Forgot your Password?"
                
            case . errorCodeWeakPassword:
                return "Password must be at least 6 characters"
                
            case .errorCodeEmailAlreadyInUse:
                return "Email alread in use with a different account, Sign in or try forgot my password"
                
            case . errorCodeAccountExistsWithDifferentCredential:
                return "User already linked with a different account, Sign in!"
                
            case .errorCodeProviderAlreadyLinked:
                return "You are already registered, Sign in or try forgot my password"
                
            default:
                // This is a general error which is not handled by the above list
                print("Error General: ",error?.localizedDescription ?? "")
                return "Error Signing in"
            }
            
        }
        
        return ""
    }
}
