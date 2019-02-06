//
//  EditStepViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 06/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit


//protocol ChildViewControllerDelegate {
//    func childViewControllerResponse(someText: String)
//}


class EditStepViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate {

//    var delegate: ChildViewControllerDelegate
    
    @IBOutlet weak var dimmerView: UIView!
    @IBOutlet weak var materialsCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var imageSmall: UIImageView!
    
    
    var parentviewcontroller: GuideStepViewController!
    
    let items = ["Leer", "Schaar"]
    
//    var holdingNavigationController: AlwaysPoppableNavigationController!
//    var activeStepView: GuideStepViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        materialsCollectionView.delegate = self
        materialsCollectionView.dataSource = self
        
        self.descriptionTextField.delegate = self
        
//
//        var activeStepView: GuideStepViewController!
        
        
//        holdingNavigationController = self.navigationController as? AlwaysPoppableNavigationController
//
//        activeStepView = holdingNavigationController.parent as? GuideStepViewController
//
        self.view.backgroundColor = .clear
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.isNavigationBarHidden = true
        
        let guideHoldingController = presentingViewController as? GuideHoldingViewController
        let indexOfHack = guideHoldingController?.scrollViewController.currentIndex
        parentviewcontroller = guideHoldingController?.scrollViewController.viewControllers[(guideHoldingController?.scrollViewController.currentIndex)!] as! GuideStepViewController

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        modalPresentationStyle = .overFullScreen //dont dismiss the presenting view controller when presented
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "materialInListCell", for: indexPath) as! ItemInMaterialListEditCollectionViewCell
        
        cell.itemName.text = items[indexPath.row]
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
////       let cell = collectionView.cellForItem(at: indexPath) as! ItemInMaterialListEditCollectionViewCell
////        let widthText = cell.itemName.bounds.width
////        return CGSize(width: CGFloat(widthText+30), height: 35)
//    }
    
    @IBAction private func changePhoto(_ sender: UIButton) {
    }
    
    @IBAction private func editDone(_ sender: UIButton) {
        
        parentviewcontroller.logChange(text: descriptionTextField.text)
        
        dismiss(animated: true, completion: nil)
        
        
//        activeStepView.logChange(text: "Test")
    }
    
    @IBAction private func editSteps(_ sender: UIButton) {
        performSegue(withIdentifier: "editStepOrder", sender: sender)
    }
    
    @IBAction private func addAStep(_ sender: UIButton) {
    }
    
    
    @IBAction private func addItem(_ sender: UIButton) {
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let controller = segue.destination as? GuideStepViewController {
//            controller.textChanged(text: "TESTTTTTTTTTTTT")
//            controller.delegate = self
//        }
//    }
 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
