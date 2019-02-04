//
//  HackStartViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 04/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class HackStartViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let materialsCollected = false
    private var showingHandleiding = true
    private var showingTesten = true
    private var readyForTesting = true
    private var activeStep = 0
    
    
    @IBOutlet weak var testDeHackButton: UIButton!
    @IBOutlet weak var testHackText: UILabel!
    @IBOutlet weak var indicatorTestImage: UIImageView!
    @IBOutlet weak var collapsingIconTestImage: UIImageView!
    @IBOutlet weak var collapsingIconHandleidingImage: UIImageView!
    @IBOutlet weak var actionButtonHandleidingButton: UIButton!
    @IBOutlet weak var hackLockedText: UILabel!
    @IBOutlet weak var indicatorHandleidingImage: UIImageView!
    @IBOutlet weak var numberOfHearts: UILabel!
    @IBOutlet weak var numberOfStepsText: UILabel!
    @IBOutlet weak var diffucultiyText: UILabel!
    @IBOutlet weak var bestOfLabelImage: UIImageView!
    @IBOutlet weak var hackImage: UIImageView!
    @IBOutlet weak var headerViewHandleiding: UIView!
    @IBOutlet weak var headerViewTesten: UIView!
    @IBOutlet weak var aanvraagContentView: UIView!
    
    
    @IBOutlet weak var heightContent: NSLayoutConstraint!
    @IBOutlet weak var handleidingHeight: NSLayoutConstraint!
    @IBOutlet weak var testenHeight: NSLayoutConstraint!
    
    
    let height = [217, 188]
    
    let heighttesten = [240, 138]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTaps()
        configureViews()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    private func setupTaps() {
        let tapHandleiding = UITapGestureRecognizer(target: self, action: #selector(showHandleidingView))
        headerViewHandleiding.addGestureRecognizer(tapHandleiding)
        headerViewHandleiding.isUserInteractionEnabled = true
        
        let tapTesten = UITapGestureRecognizer(target: self, action: #selector(showTestenView))
        headerViewTesten.addGestureRecognizer(tapTesten)
        headerViewTesten.isUserInteractionEnabled = true
    }
    
    
    private func configureViews() {
        if showingHandleiding {
            aanvraagContentView.isHidden = false
            if activeStep > 0 {
                handleidingHeight.constant = 187
            } else {
                handleidingHeight.constant = 216
            }
            collapsingIconHandleidingImage.image = UIImage(named: "arrowStepOpen")
        } else {
            aanvraagContentView.isHidden = true
            collapsingIconHandleidingImage.image = UIImage(named: "arrowStepCollapsed")
            handleidingHeight.constant = 54
        }
        
        if showingTesten {
            collapsingIconTestImage.image = UIImage(named: "arrowStepOpen")
            if readyForTesting == false {
                hackLockedText.isHidden = false
                testDeHackButton.isHidden = true
                testHackText.isHidden = true
                testenHeight.constant = 138
            } else {
                testenHeight.constant = 241
                hackLockedText.isHidden = true
                testDeHackButton.isHidden = false
                testHackText.isHidden = false
            }
        } else {
            collapsingIconTestImage.image = UIImage(named: "arrowStepCollapsed")
            testenHeight.constant = 54
            hackLockedText.isHidden = true
            testDeHackButton.isHidden = true
            testHackText.isHidden = true
        }
        

        if readyForTesting {
            indicatorHandleidingImage.image = UIImage(named: "projectStepDone")
        } else {
            indicatorHandleidingImage.image = UIImage(named: "projectStepToDo")
        }
        
        
        calculateScrollViewAndUpdate()
    }
    
    private func calculateScrollViewAndUpdate() {
        let totalHeightViews = testenHeight.constant + handleidingHeight.constant + 448 + 50
        print("update scrollView to height of \(totalHeightViews)")
        print("height of viewcontroller is \(view.frame.height)")
        if totalHeightViews < view.frame.height {
            heightContent.constant = view.frame.height - 50
        } else {
            heightContent.constant = totalHeightViews
        }
    }
    

    @IBAction func showHandleiding(_ sender: UIButton) {
    }
    
    
    @IBAction func showMaterials(_ sender: UIButton) {
    }
    
    @IBAction func showComments(_ sender: UIButton) {
    }
    
    @IBAction func testHack(_ sender: UIButton) {
    }
    
    @IBAction func startGuide(_ sender: UIButton) {
    }
    
    @objc func showHandleidingView() {
        showingHandleiding = !showingHandleiding
        configureViews()
    }
    
    @objc func showTestenView() {
        showingTesten = !showingTesten
        configureViews()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
