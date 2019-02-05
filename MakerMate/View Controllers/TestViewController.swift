//
//  TestViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 04/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class GuideStepViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    private var numberOfNeededItems = 5
    
    @IBOutlet weak var stepIndecator: UICollectionView!
    @IBOutlet weak var itemsNeeded: UICollectionView!
    @IBOutlet weak var itemsNeededHeight: NSLayoutConstraint!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var gebruikteItemsLabel: UILabel!
    @IBOutlet weak var stepIndecatorLabel: UILabel!
    @IBOutlet weak var stepExplanation: UILabel!
    
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    
    private var indexPage: Int = 0
    
    private var numViewControllers: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepIndecator.delegate = self
        stepIndecator.dataSource = self
        itemsNeeded.delegate = self
        itemsNeeded.dataSource = self
        // Do any additional setup after loading the view.
        
        
        
        setupUI()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return numViewControllers
        } else {
            return numberOfNeededItems
        }
        
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
            
            cell.nameItemLabel.text = "Plasticine/klei"
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
        if numberOfNeededItems >= 1 {
             itemsNeededHeight.constant = CGFloat(numberOfNeededItems * 35)
        } else {
            itemsNeeded.isHidden = true
            lineView.isHidden = true
            gebruikteItemsLabel.isHidden = true
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension TestViewController: ColoredView {}
