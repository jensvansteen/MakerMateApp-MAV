//
//  Stap4AanvraagViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 02/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap4AanvraagViewController: UIViewController, UITextViewDelegate {
    
    var fieldsFilledIn = false
    let placeholder = "Omdat Annick een spierziekte en heeft daardoor weinig kracht in haar handen. Ze kan hierdoor heel moeilijk een blikje openen."
    
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionField.delegate = self
        
        
        configureTextGesture()
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePop))
        backView.addGestureRecognizer(tap)
        backView.isUserInteractionEnabled = true
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        descriptionField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        descriptionField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        descriptionField.borderColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 0.537254902, alpha: 1)
        if descriptionField.text == placeholder {
            descriptionField.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        descriptionField.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        if descriptionField.text != "" {
            descriptionField.borderColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
        } else {
            descriptionField.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        checkFields()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    

    @IBAction func goToNextView(_ sender: UIButton) {
        if fieldsFilledIn {
            performSegue(withIdentifier: "GoToStep5", sender: nil)
        } else {
            let alert = UIAlertController(title: "Er missen velden", message: "Gelieve in te vullen", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action )
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func checkFields() {
        if descriptionField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && descriptionField.text != placeholder{
            fieldsFilledIn = true
            nextButton.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
            nextButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            nextButton.borderWidth = 0
        } else {
            descriptionField.text = placeholder
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            nextButton.setTitleColor(#colorLiteral(red: 0.7254901961, green: 0.5882352941, blue: 0.2980392157, alpha: 1), for: .normal)
            nextButton.borderWidth = 1
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func configureTextGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Stap4AanvraagViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func handleTap() {
        print("helooooooo")
        view.endEditing(true)
    }
    
    @objc func handlePop() {
        self.navigationController?.popViewController(animated: false)
    }
 
    
}
