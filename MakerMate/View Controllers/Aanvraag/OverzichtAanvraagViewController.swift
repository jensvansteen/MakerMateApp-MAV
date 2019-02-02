//
//  OverzichtAanvraagViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 02/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class OverzichtAanvraagViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var targetGroupLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePop))
        backView.addGestureRecognizer(tap)
        backView.isUserInteractionEnabled = true
        
        setupUI()

        // Do any additional setup after loading the view.
       
    }
    
    func setupUI() {
        nameLabel.text = aanvraagSteps.sharedInstance.firstName
        targetGroupLabel.text = aanvraagSteps.sharedInstance.targetGroup
        shortDescriptionLabel.text = aanvraagSteps.sharedInstance.wish
        longDescriptionLabel.text = aanvraagSteps.sharedInstance.description
        
    }
    
    @IBAction func SubmitRequest(_ sender: UIButton) {
         aanvraagSteps.sharedInstance.pushToFirebase()
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
