//
//  Stap5AanvraagViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 02/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap5AanvraagViewController: UIViewController {
    
    var selectedGroup: Int?
    
    @IBOutlet weak var kinderenView: UIView!
    @IBOutlet weak var jongerenView: UIView!
    @IBOutlet weak var volwassenenView: UIView!
    @IBOutlet weak var ouderenView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet var groupText: [UILabel]!
    @IBOutlet var selectionIndecators: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePop))
        backView.addGestureRecognizer(tap)
        backView.isUserInteractionEnabled = true
        
        setupSelection()
    }
    
    
    func setupSelection() {
        let tapChild = UITapGestureRecognizer(target: self, action: #selector(Stap5AanvraagViewController.handleSelectionChild))
        kinderenView.addGestureRecognizer(tapChild)
        kinderenView.isUserInteractionEnabled = true
        let tapJunior = UITapGestureRecognizer(target: self, action: #selector(Stap5AanvraagViewController.handleSelectionJunior))
        jongerenView.addGestureRecognizer(tapJunior)
        jongerenView.isUserInteractionEnabled = true
        let tapAdult = UITapGestureRecognizer(target: self, action: #selector(Stap5AanvraagViewController.handleSelectionAdult))
        volwassenenView.addGestureRecognizer(tapAdult)
        volwassenenView.isUserInteractionEnabled = true
        let tapSenior = UITapGestureRecognizer(target: self, action: #selector(Stap5AanvraagViewController.handleSelectionSenior))
        ouderenView.addGestureRecognizer(tapSenior)
        ouderenView.isUserInteractionEnabled = true
    }
    
    func updateSelection(tag: Int) {
        if selectedGroup != nil {
            for text in groupText {
                if text.tag == selectedGroup {
                    text.font = UIFont (name: "AvenirNext-Regular", size: 20)
                }
            }
            for selectionIndecator in selectionIndecators {
                if selectionIndecator.tag == selectedGroup {
                    selectionIndecator.image = UIImage(named: "notSelected-stap5Aanvraag")
                }
            }
            
        }
        for text in groupText {
            if text.tag == tag {
                text.font = UIFont (name: "AvenirNext-Bold", size: 20)
            }
        }
        for selectionIndecator in selectionIndecators {
            if selectionIndecator.tag == tag {
                selectionIndecator.image = UIImage(named: "selected-stap5Aanvraag")
            }
        }
        selectedGroup = tag
        checkFields()
    }
    
    
        @IBAction func goToNextView(_ sender: UIButton) {
            if selectedGroup != nil {
                performSegue(withIdentifier: "ShowSummary", sender: nil)
            } else {
                let alert = UIAlertController(title: "Selecteer een groep", message: "Gelieve te selecteren", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(action )
                present(alert, animated: true, completion: nil)
            }
        }
    
        private func checkFields() {
            if selectedGroup != nil {
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
    
    @objc func handleSelectionChild() {
        updateSelection(tag: 0)
    }
    
    @objc func handleSelectionJunior() {
        updateSelection(tag: 1)
    }
    
    @objc func handleSelectionAdult() {
        updateSelection(tag: 2)
    }
    
    @objc func handleSelectionSenior() {
        updateSelection(tag: 3)
    }
    
    @objc func handleTap() {
        print("helooooooo")
        view.endEditing(true)
    }
    
    @objc func handlePop() {
        self.navigationController?.popViewController(animated: false)
    }
    
    
}

