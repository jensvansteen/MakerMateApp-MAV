//
//  Stap6KennismakingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 11/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap6KennismakingViewController: UIViewController {
    
    private var optionValues = [0: false, 1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false, 8: false]
    private var fieldsFilledIn = false
    
    
    @IBOutlet weak private var nextButton: UIButton!
    @IBOutlet weak private var backView: UIView!
    @IBOutlet weak private var closeView: UIImageView!
    
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
    
    
    func checkFields() {
        if optionValues.values.contains(true) {
            fieldsFilledIn = true
            nextButton.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
            nextButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            nextButton.borderWidth = 0
        } else {
            fieldsFilledIn = false
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            nextButton.setTitleColor(#colorLiteral(red: 0.7254901961, green: 0.5882352941, blue: 0.2980392157, alpha: 1), for: .normal)
            nextButton.borderWidth = 1
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc private func handlePop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleDismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func optionSelected(_ sender: UIButton) {
            optionValues[sender.tag] = !optionValues[sender.tag]!
            let theSender = sender as UIButton
            if theSender.backgroundColor == #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1) {
            theSender.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            theSender.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1), for: .normal)
            } else {
            theSender.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
            theSender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            }
            checkFields()
    }
    

    @IBAction func goToNextStep(_ sender: UIButton) {
        if fieldsFilledIn {
            performSegue(withIdentifier: "AanvraagStap7", sender: sender)
        }
    }
    
}
