//
//  LoginViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 11/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            // 2
            if user != nil {
                // 3
                self.performSegue(withIdentifier: "UserLogIn", sender: nil)
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
    }
    
    @IBAction func didEndExit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    @IBAction func logInPresses(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) {(user,error) in
            if let error = error {
                print(error)
            }
        }
    }
}
