//
//  Stap2AanvraagViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 02/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap2AanvraagViewController: UIViewController, UITextFieldDelegate {

  
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var provinceField: UITextField!
    @IBOutlet weak var postalField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    private var fieldsFilledIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.streetField.delegate = self
        self.cityField.delegate = self
        self.provinceField.delegate = self
        self.postalField.delegate = self
        
     
        configureTextGesture()
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePop))
        backView.addGestureRecognizer(tap)
        backView.isUserInteractionEnabled = true
        
       
    }
    

    @IBAction func didEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    @IBAction func EditingStarted(_ sender: UITextField) {
        sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sender.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        sender.borderColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 0.537254902, alpha: 1)
    }
    
    @IBAction func EditingDone(_ sender: UITextField) {
        sender.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        if sender.text != "" {
            sender.borderColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
        } else {
            sender.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        checkFields()
    }
    
    @IBAction func EditingChanged(_ sender: UITextField) {
        sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sender.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        sender.borderColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 0.537254902, alpha: 1)
    }
    
    @IBAction func goToNextView(_ sender: UIButton) {
        if fieldsFilledIn {
            if let zipumberCheck = Int(postalField.text!) {
                aanvraagSteps.sharedInstance.setStep2(adress: streetField.text!, city: cityField.text!, province: provinceField.text!, zip: zipumberCheck)
                performSegue(withIdentifier: "GoToStep3", sender: nil)
            } else {
                let alert = UIAlertController(title: "postcode mag geen letters bevatten", message: "Gelieve te corrigeren", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(action )
                present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Er missen velden", message: "Gelieve in te vullen", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action )
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func checkFields() {
        if streetField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && cityField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && provinceField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && postalField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            fieldsFilledIn = true
            nextButton.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
            nextButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            nextButton.borderWidth = 0
        } else {
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            nextButton.setTitleColor(#colorLiteral(red: 0.7254901961, green: 0.5882352941, blue: 0.2980392157, alpha: 1), for: .normal)
            nextButton.borderWidth = 1
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func configureTextGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Stap2AanvraagViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func handlePop() {
        self.navigationController?.popViewController(animated: false)
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
