//
//  Stap4HackTestenViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 13/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap4HackTestenViewController: UIViewController {

    @IBOutlet weak private var closeView: UIImageView!
    @IBOutlet weak private var backView: UIView!
    @IBOutlet weak private var nameHackTextField: UITextField!
    @IBOutlet weak var descriptionHackTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func completeHack(_ sender: UIButton) {
        HackTest.sharedInstance.hackWasTested()
        self.navigationController?.popToRootViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    HackTest.sha

}
