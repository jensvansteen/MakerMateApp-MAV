//
//  Stap1KennismakingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 09/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap1KennismakingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func afrondenKennismaking(_ sender: Any) {
        
        kennismakingSteps.sharedInstance.stap1(mobiliteitsKlasse: 2)
        
        
        kennismakingSteps.sharedInstance.pushToFirebase()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
