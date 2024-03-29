//
//  TestViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 04/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import Firebase

class GuideStepViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func childViewControllerResponse(someText: String) {
        print(someText)
    }
    
    var textdes = String()
    
    var itemList = [String]() {
        didSet {
            itemsNeeded.reloadData()
        }
    }
    
    var step: StapHack?
    
    private var numberOfNeededItems = 5
    
    @IBOutlet weak var stepIndecator: UICollectionView!
    @IBOutlet weak var itemsNeeded: UICollectionView!
    @IBOutlet weak var itemsNeededHeight: NSLayoutConstraint!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var gebruikteItemsLabel: UILabel!
    @IBOutlet weak var stepIndecatorLabel: UILabel!
    @IBOutlet weak var stepExplanation: UILabel!
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    @IBOutlet weak var imageStep: UIImageView!
    
    private var indexPage: Int = 0
    
    private var numViewControllers: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepIndecator.delegate = self
        stepIndecator.dataSource = self
        itemsNeeded.delegate = self
        itemsNeeded.dataSource = self
        
        // Do any additional setup after loading the view.
        
        
//        setupUI()
    }
    
    
//    override func viewDidAppear() {
//        super.viewDidAppear()
//
////        stepIndecator.delegate = self
////        stepIndecator.dataSource = self
////        itemsNeeded.delegate = self
////        itemsNeeded.dataSource = self
//
//        // Do any additional setup after loading the view.
//
//
//        setupUI()
//    }
    
    
    
    func changeValuesStep(_ notificatie:Notification){
        let newText = notificatie.userInfo!["text"] as! String
        stepExplanation.text = newText
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setupUI()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return numViewControllers
        } else {
            return itemList.count
        }
        
    }
    
    func logChange(text: String ) {
        stepExplanation.text = text
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stepCell", for: indexPath)
            
            if indexPath.row == indexPage {
                cell.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
            } else {
                cell.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
            }
            return cell
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! itemNeededCollectionViewCell
            
            cell.nameItemLabel.text = itemList[indexPath.row]
            return cell
        } else {
            let cell = UICollectionViewCell()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 0 {
            let widthViewController = view.frame.width
            
            let widthOneCell = (widthViewController/CGFloat(numViewControllers)) - 1
            
            return CGSize(width: widthOneCell, height: 8)
        } else {
            return CGSize(width: 342.0, height: 25.0)
        }
    }
    
    
    
    func setupUI() {
        
        if step != nil {
             stepExplanation.text = step!.description
             itemList = step!.items!
            
            if step!.stepImage != nil {
                self.imageStep.image = step!.stepImage
            } else {
               getStepImage()
            }
            
             itemsNeeded.reloadData()
        }
       
        
        if numberOfNeededItems >= 1 {
            itemsNeededHeight.constant = CGFloat(numberOfNeededItems * 35)
        } else {
            itemsNeeded.isHidden = true
            lineView.isHidden = true
            gebruikteItemsLabel.isHidden = true
        }
        
        
    }
    
    private func getStepImage() {
        
        let referenceToStorage = Storage.storage()
        
        var gsReference: StorageReference!
        
        if step!.photoAdjusted == true {
            gsReference = referenceToStorage.reference(forURL: "gs://makermate-a22cc.appspot.com/hackSteps/\(step!.hackId)/stap\(step!.order).jpg")
        } else {
            gsReference = referenceToStorage.reference(forURL: "gs://makermate-a22cc.appspot.com/hackSteps/\(step!.orginalHackId!)/stap\(step!.order).jpg")
        }
        
        gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("the error is \(error)")
            } else {
                let image = UIImage(data: data!)
                self.imageStep.image = image
                
            }
        }
        
    }
    
    
    func setupHeight(theindex: Int, numViewControllers: Int) {
        self.numViewControllers = numViewControllers
        self.indexPage = theindex
        heightScrollView.constant = CGFloat(theindex * 300)
        stepIndecatorLabel.text = "\(indexPage+1)/\(self.numViewControllers)"
        
        calculateHeight()
    }
    
    
    func calculateHeight() {
        var height: CGFloat = 0
        if numberOfNeededItems >= 1 {
            height = stepExplanation.bounds.size.height + itemsNeededHeight.constant + 448 + 37 + 60
        } else {
            height = stepExplanation.bounds.size.height + 448 + 37 + 40
        }
        
        if height > view.frame.height {
            heightScrollView.constant = height
        } else {
            heightScrollView.constant = view.frame.height
        }
    }
    
    
    func textChanged(text: String?) {
        print(text)
//        stepExplanation.text = text
    }
    
    
    @IBAction func showEditOptions(_ sender: UIButton) {
        
        performSegue(withIdentifier: "showEdit", sender: sender)
        
        //        guard let editView = storyboard?.instantiateViewController(withIdentifier: "navigationHolderEditStep") as? AlwaysPoppableNavigationController else {
        //            assertionFailure("No view controller ID MaxiSongCardViewController in storyboard")
        //            return
        //        }
        //
        //        present(editView, animated: true)
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

