//
//  Stap2TestHackViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 12/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap2TestHackViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let mooodData = [1: "Spannend", 2: "Controle", 3: "Verveling", 4: "Comfortabel", 5: "Ontspanning", 6: "Apathie", 7: "Bezorgdheid", 8: "Angst"]
    
    @IBOutlet weak private var emotieCollectionVIew: UICollectionView!
    @IBOutlet weak private var closeView: UIImageView!
    @IBOutlet weak private var backView: UIView!
    @IBOutlet weak private var nextButton: UIButton!
    
    private var didSelectItem = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emotieCollectionVIew.delegate = self
        emotieCollectionVIew.dataSource = self
        // Do any additional setup after loading the view.
        
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
        return mooodData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moodCell", for: indexPath) as! MoodCollectionViewCell
        cell.setMood(mood: mooodData[indexPath.row + 1]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem = true
        checkFields()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func checkFields() {
        if didSelectItem {
            nextButton.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
            nextButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            nextButton.borderWidth = 0
        } else {
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            nextButton.setTitleColor(#colorLiteral(red: 0.7254901961, green: 0.5882352941, blue: 0.2980392157, alpha: 1), for: .normal)
            nextButton.borderWidth = 1
        }
    }
    
    @IBAction private func nextStep(_ sender: UIButton) {
        if didSelectItem {
            performSegue(withIdentifier: "GoToStep3Test", sender: sender)
        }
    }
    
    
    @objc private func handleDismiss() {
        HackTest.sharedInstance.clearInstance()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func handlePop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
