//
//  Stap1TestHackViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 12/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap1TestHackViewController: UIViewController, UITextViewDelegate {
    
     var fieldsFilledIn = false
     let placeholder = "bv. Ik had nooit kunnen denken dat de handvaten zo goed gingen passen."

    @IBOutlet weak private var testTextField: UITextView!
    @IBOutlet weak private var nextButton: UIButton!
    @IBOutlet weak private var backView: UIView!
    @IBOutlet weak private var closeView: UIImageView!
    @IBOutlet weak private var thumbUpImage: UIImageView!
    @IBOutlet weak private var thumbDownImage: UIImageView!
    private var hackLiked: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testTextField.delegate = self
        
        configureTextGesture()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePop))
        backView.addGestureRecognizer(tap)
        backView.isUserInteractionEnabled = true
        
        let tapClose = UITapGestureRecognizer(target: self, action: #selector(handleClose))
        closeView.addGestureRecognizer(tapClose)
        closeView.isUserInteractionEnabled = true
        
        let tapUpp = UITapGestureRecognizer(target: self, action: #selector(handleTapLike))
        thumbUpImage.addGestureRecognizer(tapUpp)
        thumbUpImage.isUserInteractionEnabled = true
        
        let tapDown = UITapGestureRecognizer(target: self, action: #selector(handleTapNotLike))
        thumbDownImage.addGestureRecognizer(tapDown)
        thumbDownImage.isUserInteractionEnabled = true
        
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        testTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        testTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        testTextField.borderColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 0.537254902, alpha: 1)
        if testTextField.text == placeholder {
            testTextField.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        testTextField.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        if testTextField.text != "" {
            testTextField.borderColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
        } else {
            testTextField.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        checkFields()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    private func checkFields() {
        if testTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && testTextField.text != placeholder && hackLiked != nil {
            fieldsFilledIn = true
            nextButton.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
            nextButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            nextButton.borderWidth = 0
        } else {
            testTextField.text = placeholder
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            nextButton.setTitleColor(#colorLiteral(red: 0.7254901961, green: 0.5882352941, blue: 0.2980392157, alpha: 1), for: .normal)
            nextButton.borderWidth = 1
        }
    }
    
    private func updateUI() {
        if let hackLiked = hackLiked {
            if hackLiked {
                thumbUpImage.image = UIImage(named: "thumb-up-active")
                thumbDownImage.image = UIImage(named: "thumb-down")
            } else {
                thumbUpImage.image = UIImage(named: "thumb-up")
                thumbDownImage.image = UIImage(named: "thumb-down-active")
            }
        }
    }
    
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func handlePop() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func handleClose() {
        HackTest.sharedInstance.clearInstance()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleTapLike() {
        if let hackedliked = hackLiked {
            hackLiked = !hackedliked
        } else {
            hackLiked = true
        }
        updateUI()
    }
    
    @objc private func handleTapNotLike() {
        if let hackedliked = hackLiked {
            hackLiked = !hackedliked
        } else {
            hackLiked = false
        }
        updateUI()
    }
    
    @IBAction private func goToStep2(_ sender: UIButton) {
        if fieldsFilledIn {
            performSegue(withIdentifier: "GoToStep2Test", sender: nil)
        } else {
            let alert = UIAlertController(title: "Er missen velden", message: "Gelieve in te vullen", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action )
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func configureTextGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Stap4AanvraagViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    
}
