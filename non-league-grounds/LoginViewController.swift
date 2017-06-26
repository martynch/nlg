//
//  LoginViewController.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 16/05/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn
import TwitterKit


class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    
    enum LoginType:String {
        case login
        case signup
        case forgotPassword
    }
    
    var currentLoginType:LoginType = .login{
        
        didSet{
            
            DispatchQueue.main.async {
                switch self.currentLoginType {
                case .signup:
                    
                    self.loginBtn.setTitle("Sign Up", for: .normal)
                    self.signupBtn.setTitle("Sign In", for: .normal)
                    
                    UIView.animate(withDuration: 0.48) {
                        
                        self.repeatLabelStack.isHidden = false
                        self.passwordsStack.isHidden = false
                        
                    }
                    
                case .login:
                    
                    self.loginBtn.setTitle("Sign In", for: .normal)
                    self.signupBtn.setTitle("Sign Up", for: .normal)
                    
                    UIView.animate(withDuration: 0.68) {
                        
                        self.repeatLabelStack.isHidden = true
                        self.passwordsStack.isHidden = false
                    }
                    
                case .forgotPassword:
                    self.loginBtn.setTitle("Reset My Password", for: .normal)
                    self.signupBtn.setTitle("Sign In", for: .normal)
                    
                    UIView.animate(withDuration: 0.48) {
                        self.passwordsStack.isHidden = true
                    }
                    
                }
            }
        }
    }
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    @IBOutlet weak var repeatLabelStack: UIStackView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var passwordsStack: UIStackView!
    
    
    @IBAction func signUp(_ sender: Any) {
        
        clearLoginTextFields()
        
        self.currentLoginType = self.currentLoginType == .login ? .signup : .login
        
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        
        self.currentLoginType = .forgotPassword
        self.statusLabel.text = ""
    }
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    
    @IBAction func login(_ sender: Any) {
        
        userName.delegate = self
        password.delegate = self

        
        self.userName.resignFirstResponder()
        self.password.resignFirstResponder()
        self.repeatPassword.resignFirstResponder()
        self.passwordsStack.resignFirstResponder()
        
        
        self.progress.startAnimating()
        switch self.currentLoginType {
            
        case .login:

            let email = self.userName.text
            let password = self.password.text
            
            FirebaseManager.login(email: email!, password: password!, completion: { (status: Bool, error: Error?) in
                
                if status && error == nil {
                    if FirebaseManager.isEmailVerified {
                        
                        self.dismiss(animated: true, completion: nil)
                        print (error?.localizedDescription ?? "")
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let LoginVC = storyboard.instantiateViewController(withIdentifier: "ReavealVC") as! SWRevealViewController
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = LoginVC
                    
                    } else {
                        
                        DispatchQueue.main.async {
                            self.statusLabel.text = "Your email is not verified. Please check your email"
                            self.progress.stopAnimating()
                            print ("have we stopped at email not verified")
                            self.clearLoginTextFields()
                        }
                    }
                    
                } else {
                    
                    DispatchQueue.main.async {
                        self.progress.stopAnimating()
                        self.statusLabel.text = FirebaseManager.StringFromError(error: error)
                        print("have we stopped at email after its not verified")
                        self.clearLoginTextFields()
                    }
                    print("HERE")
                }
                print("HERE")
            })
            
            
        case .signup:
            
            if self.password.text == self.repeatPassword.text{
                
                let email = self.userName.text
                let password = self.password.text
                
                FirebaseManager.LinkWithEmailAndPassword(email: email!, password: password!, completion: { (status: Bool, error: Error?) in
                    
                    if status && error == nil {
                        
                        self.dismiss(animated: true, completion: nil)
                        
                        self.progress.stopAnimating()
                        self.statusLabel.text = "Email verification sent, please check you inbox"
                        print(error?.localizedDescription ?? "")
                        
                    } else {
                        
                        DispatchQueue.main.async {
                            self.progress.stopAnimating()
                            self.statusLabel.text = FirebaseManager.StringFromError(error: error)

                        }
                    }
                })
                self.view.endEditing(true)
                clearLoginTextFields()
                
            }else{
                self.progress.stopAnimating()
                self.statusLabel.text = "Passwords do not match, please try again!"
            }
            
        case .forgotPassword:
            
            FirebaseManager.sendPasswordReset(email: self.userName.text!, completion: { (status:Bool) in
                
                DispatchQueue.main.async {
                    self.progress.stopAnimating()
                    self.statusLabel.text = status ? "Reset password sent" : "Error sending reset password"
                }
            })
            
            break
        }
        
    }
    
    // FaceBook Social Logins Start begin here    
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
    
    // Twitter UIButton
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
    
    //Google SignIn 
    @IBAction func goggleLogin(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.\
        
        GIDSignIn.sharedInstance().clientID = "1066303110839-iis5am9f5rlnqtd0ggit11r426629gvu.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        self.statusLabel.text = ""
        self.repeatLabelStack.isHidden = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            print(error.localizedDescription)
            return
        }
        
        Helper.helper.loginWithGoogle(authentication: user.authentication)
        
        Helper.helper.showAlert(title: "Email in use, did you use another methond to register", msg: "please try again", controller: self)
    }
    
    func clearLoginTextFields() {
        
        self.userName.text = ""
        self.password.text = ""
        self.repeatPassword.text = ""
    }
    
 }

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.resignFirstResponder()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        statusLabel.text = ""
    }
}
