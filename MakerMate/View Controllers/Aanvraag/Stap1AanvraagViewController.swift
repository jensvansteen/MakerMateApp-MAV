//
//  Stap1AanvraagViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 01/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap1AanvraagViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.delegate = self
        firstnameField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
