//
//  loginViewController.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/20/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginStatusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        activityIndicator.stopAnimating()
        loginStatusLabel.text = ""
        signInButton.enabled = true
    }
    
    @IBAction func login(sender: UIButton) {
        
        if let username = emailTextField.text where username != "", let password = passwordTextField.text where password != "" {
            
            activityIndicator.startAnimating()
            loginStatusLabel.text = ""
            signInButton.enabled = false
            
            Client.sharedInstance.login(username, password: password, completionHandler: { result, error in
                dispatch_async(dispatch_get_main_queue()) {
                    self.activityIndicator.stopAnimating()
                    self.signInButton.enabled = true
                    
                    if let message = result["message"] as? String {
                        self.loginStatusLabel.text = message
                    }
                }
                
                if let token = result["token"] as? String {
                    print(result)
                    Client.sharedInstance.token = token
                    dispatch_async(dispatch_get_main_queue()) {
                        self.loginStatusLabel.text = "Login successful."
                    }
                }
                
            })
        } else {
            loginStatusLabel.text = "Please fill the email and password."
        }
        
    }
    
}