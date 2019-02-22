//
//  SignUpViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 12/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            performSegue(withIdentifier: "personalInformation", sender: sender)
        }
    }
    
    @IBAction func endOnExit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "personalInformation"{
            
            let detailVC = segue.destination as! PersonallInfoViewController
            detailVC.password = self.passwordTextField.text!
            detailVC.email = self.emailTextField.text!
        }
    }
    
}
