//
//  Stap1KennismakingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 09/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class Stap1KennismakingViewController: UIViewController {
    
     let ageClass = [1: "kinderen (-12 jaar)", 2: "jongeren (-26 jaar)", 3: "volwassenen (26+ jaar)", 4: "senioren (65+ jaar)"]
    
     var db: Firestore!
    
     private var hacksCollectionRef: CollectionReference!
     private var hackListener: ListenerRegistration!
     private var hack: Hack?
     private var fieldsFilledIn = false

    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var doelgroepTextField: UITextField!
    @IBOutlet weak private var wishTextfield: UITextView!
    @IBOutlet weak private var nextButton: UIButton!
    @IBOutlet weak private var backView: UIView!
    @IBOutlet weak var closeView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        hacksCollectionRef = db.collection("Hacks")
        
        var currentProject = Firestore.firestore().collection("Projects").document(LastProject.shared.idLastProject!)
        
        
        //Get project
        currentProject.getDocument() { (querysnapshot, err) in
            if let err = err {
                print("no project found with \(LastProject.shared.idLastProject)")
            } else {
                let project = Project.parseOneData(snapshot: querysnapshot)
                self.setUpUI(project: project)
            }
        }
        
        
        //Setup backButton
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(handlePop))
        backView.addGestureRecognizer(tapBack)
        backView.isUserInteractionEnabled = true
        
        
        //Setup closeButton
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        closeView.addGestureRecognizer(tapDismiss)
        closeView.isUserInteractionEnabled = true
    }
    
 
    func setUpUI(project: Project?) {
        if let project = project {
            nameTextField.text = project.firstNameClient!
            doelgroepTextField.text = ageClass[project.targetGroup!]
            wishTextfield.text = project.description!
            checkFields()
        }
    }
    
    
    private func checkFields() {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && doelgroepTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && wishTextfield?.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
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
    
    
    @objc private func handlePop() {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @objc private func handleDismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }


    @IBAction func kennisMakingStap1(_ sender: UIButton) {
        
        if fieldsFilledIn {
              performSegue(withIdentifier: "AanvraagStap2", sender: sender)
        }
        
    }
    
}
