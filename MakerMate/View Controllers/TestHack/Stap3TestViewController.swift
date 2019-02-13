//
//  Stap3TestViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 13/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap3TestViewController: UIViewController {

    @IBOutlet weak private var closeView: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(handlePop))
        backView.addGestureRecognizer(tapBack)
        backView.isUserInteractionEnabled = true
        
        
        //Setup closeButton
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        closeView.addGestureRecognizer(tapDismiss)
        closeView.isUserInteractionEnabled = true
    }
    

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc private func handleDismiss() {
        HackTest.sharedInstance.clearInstance()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func handlePop() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func goToNextStep(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToStep4Test", sender: sender)
    }
}
