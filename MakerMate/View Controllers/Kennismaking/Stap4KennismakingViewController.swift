//
//  Stap4KennismakingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 11/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap4KennismakingViewController: UIViewController {
    
    
    private var fieldsFilledIn = false
    @IBOutlet weak private var speakView: UIView!
    @IBOutlet weak private var hearView: UIView!
    @IBOutlet weak private var seeView: UIView!
    @IBOutlet weak private var closeView: UIImageView!
    @IBOutlet weak private var backView: UIView!
    @IBOutlet weak private var nextButton: UIButton!
    var gehoor = false
    var zien = false
    var spraak = false
    @IBOutlet weak private var spraakButton: UIButton!
    @IBOutlet weak private var gehoorButton: UIButton!
    @IBOutlet weak private var zichtButton: UIButton!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(handlePop))
        backView.addGestureRecognizer(tapBack)
        backView.isUserInteractionEnabled = true
        
        
        //Setup closeButton
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        closeView.addGestureRecognizer(tapDismiss)
        closeView.isUserInteractionEnabled = true

        checkFields()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func checkFields() {
        if zien || gehoor || spraak {
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
    
    func updateUI() {
        if spraak == true {
            spraakButton.layer.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
            spraakButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        } else {
            spraakButton.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            spraakButton.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1), for: .normal)
        }
        
        if zien == true {
            zichtButton.layer.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
            zichtButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        } else {
            zichtButton.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            zichtButton.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1), for: .normal)
        }
        
        if gehoor == true {
            gehoorButton.layer.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
            gehoorButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        } else {
            gehoorButton.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            gehoorButton.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1), for: .normal)
        }
        checkFields()
    }
    
    @objc private func handlePop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleDismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func problemSelected(_ sender: UIButton) {
        if sender.tag == 0 {
            spraak = !spraak
            gehoor = false
            zien = false
        } else if sender.tag == 1 {
            gehoor = !gehoor
            spraak = false
            zien = false
        } else if sender.tag == 2 {
            zien = !zien
            gehoor = false
            spraak = false
        }
        updateUI()
    }
    

    @IBAction func goToNextStep(_ sender: UIButton) {
        if fieldsFilledIn || sender.tag == 1 {
            performSegue(withIdentifier: "AanvraagStap5", sender: sender)
        }
    }
 
}
