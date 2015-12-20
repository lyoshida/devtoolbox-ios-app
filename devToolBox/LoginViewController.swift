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
    
    
    @IBAction func login(sender: UIButton) {
        
        if let username = emailTextField.text where username != "", let password = passwordTextField.text where password != "" {
            Client.sharedInstance.login(username, password: password, completionHandler: { result, error in
                
                print(result)
                
            })
        }
        
    }
    
}