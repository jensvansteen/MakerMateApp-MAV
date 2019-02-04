//
//  StepsProjectViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 31/01/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class StepsProjectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    

    @IBOutlet weak var stepsCollectionView: UICollectionView!
    
    let steps = [
    [
        "step": "De aanvraag",
        "access": "unlocked",
        "completed": true,
        "description": "Naam, contactgegevens, de omschrijving dat noteer je allemaal hier."
        ],
    [
        "step": "Kennismaking",
        "access": "unlocked",
        "completed": false,
        "description": "Ben je ter plaatse? Dan kunnen we beginnen! Enkele vragen over de persoon, omgeving en  handeling gidsen je naar de juiste hack(s)."
        ],
    [
        "step": "Hacks testen",
        "access": "locked",
        "completed": false,
         "description": "Naam, contactgegevens, de omschrijving dat noteer je allemaal hier."
        ],
        [
            "step": "Publiceren",
            "access": "locked",
            "completed": false,
             "description": "Naam, contactgegevens, de omschrijving dat noteer je allemaal hier."
        ]
    ]
 
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stepsCollectionView.delegate = self
        self.stepsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stepCell", for: indexPath) as! stepsCollectionViewCell
        
        cell.stepName.text = steps[indexPath.row]["step"] as? String
        cell.stepDescription.text = steps[indexPath.row]["description"] as? String
        
        if steps[indexPath.row]["access"] as! String == "locked" {
            cell.actionStep.isHidden = true
            cell.stepDescription.isHidden = true
            cell.imageStep.isHidden = true
            cell.stepName.textColor = #colorLiteral(red: 0.7254901961, green: 0.5882352941, blue: 0.2980392157, alpha: 1)
        } else if steps[indexPath.row]["access"] as! String == "unlocked" && steps[indexPath.row]["completed"] as! Bool == true {
              cell.statusImage.image = UIImage(named: "done")
              cell.actionStep.isHidden = true
              cell.stepDescription.isHidden = true
              cell.imageStep.isHidden = true
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if steps[indexPath.row]["step"] as! String == "De aanvraag" && steps[indexPath.row]["access"] as! String == "unlocked" && steps[indexPath.row]["completed"] as! Bool == false {
            print("true")
            return CGSize(width: 290, height: 120)
        } else if steps[indexPath.row]["step"] as! String == "Kennismaking" && steps[indexPath.row]["access"] as! String == "unlocked" && steps[indexPath.row]["completed"] as! Bool == false {
            return CGSize(width: 290, height: 170)
        } else if steps[indexPath.row]["completed"] as! Bool == true {
            return CGSize(width: 290, height: 46)
        }
        
        return CGSize(width: 290, height: 78)
      
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
