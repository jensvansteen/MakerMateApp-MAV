//
//  Stap2KennismakingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 11/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap2KennismakingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak private var mobiCollectionView: UICollectionView!
    @IBOutlet weak private var closeView: UIImageView!
    @IBOutlet weak private var backView: UIView!
    @IBOutlet weak private var nextButton: UIButton!
    private var fieldsFilledIn = false
    
    let mobiData = [1: " volledig actief (a)", 2: "Actief met een hulpmiddel (b)", 3: "half passief, maar heeft nog zitbalans (c)", 4: "half passief, maar heeft geen zitbalans (d)", 5: "bedlegerig (e)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobiCollectionView.delegate = self
        mobiCollectionView.dataSource = self

        //Setup backButton
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(handlePop))
        backView.addGestureRecognizer(tapBack)
        backView.isUserInteractionEnabled = true
        
        
        //Setup closeButton
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        closeView.addGestureRecognizer(tapDismiss)
        closeView.isUserInteractionEnabled = true
        
        
        checkFields()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mobiliteitscell", for: indexPath) as! mobiCollectionViewCell
        cell.mobiClassImage.image = UIImage(named: "mobfactor-\(indexPath.row+1)")
        cell.mobiClassText.text = mobiData[indexPath.row + 1]
        cell.selectionImage.image = UIImage(named: "mobiUncheck")
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        checkFields()
    }
    
    private func checkFields() {
        if mobiCollectionView.indexPathsForSelectedItems!.count >= 1 {
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
    
    @IBAction func goToNextStep(_ sender: UIButton) {
        
        if fieldsFilledIn {
            performSegue(withIdentifier: "AanvraagStap3", sender: sender)
        }
    }
    
    @objc private func handleDismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func handlePop() {
        self.navigationController?.popViewController(animated: true)
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
