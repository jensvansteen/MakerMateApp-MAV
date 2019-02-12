//
//  GuideHoldingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 04/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import Firebase

class GuideHoldingViewController: UIViewController, ScrollViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var steps = [StapHack]()
    
    var initialViewController: Int = 0
    
    var viewControllers: [UIViewController?] = []

    let viewControllerData = [0,1,2, 3, 5]
    
    var widthOneCell: CGFloat = 0.0
    
    var updateCell = BottomStepIndecatorCollectionViewCell()
    
    var scrollViewController: ScrollViewController!
    
    var firstTimeLoading = false
    
    var projectReference: DocumentReference!
    
    var hack: HackInProject?
    
    @IBOutlet weak var stepIndecatorCollectionView: UICollectionView!
    
    @IBOutlet weak var spacingLeftStepIndecator: NSLayoutConstraint!
    
    @IBOutlet weak var viewHolderCollectionView: UIView!
    public var currentPage: Int = 0 {
        didSet {
//            indexPageLabel.text = String(currentPage)
            let indexPath = IndexPath(row: currentPage, section: 0)
            if firstTimeLoading {
//                updateCell.stepImage.image = UIImage(named: "NonActiveStep")
//                updateCell.stepText.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.1960784314, alpha: 1)
            }
            stepIndecatorCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            updateCell = stepIndecatorCollectionView.cellForItem(at: indexPath) as! BottomStepIndecatorCollectionViewCell
//            updateCell.stepImage.image = UIImage(named: "ActiveStepHandleiding")
//            updateCell.stepText.textColor = .white
//            let size = CGSize(width: 44, height: 44)
//            updateCell.size = size
            firstTimeLoading = true
            stepIndecatorCollectionView.reloadData()
        }
    }
    
    public var currentCoordinationPointHolder: CGFloat = 0 {
        didSet {
            var extraSpace = CGFloat(25 - currentPage*8)
            spacingLeftStepIndecator.constant = currentCoordinationPointHolder/CGFloat(-viewControllers.count) + view.frame.width/2 - extraSpace
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeSteps()
        
        stepIndecatorCollectionView.delegate = self
        stepIndecatorCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        printCellAndViewSize()
        
    }
    
  
    func makeSteps() {
        var viewControllersColl: [UIViewController] = []
        var oderderdSteps = steps.sorted(by: { $0.order < $1.order})
        for step in oderderdSteps {
            let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "testViewController") as! GuideStepViewController

             viewCon.step = step

            viewControllersColl.append(viewCon)
        }
        
        let reviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "hackReview") as! ReviewHackViewController
        
        reviewViewController.hack = hack
        
        viewControllersColl.append(reviewViewController)
        
        viewControllers = viewControllersColl
        
        initialViewController = 1
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndificationCell", for: indexPath) as! BottomStepIndecatorCollectionViewCell
        
   
        cell.stepImage.image = UIImage(named: "NonActiveStep")
        cell.stepText.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.1960784314, alpha: 1)
        cell.stepText.font = UIFont(name: "AvenirNext-Medium", size: 18)
        
        if indexPath.row == viewControllers.count-1 {
            cell.stepImage.image = UIImage(named: "notActiveReview")
        }
        
        if indexPath.row == currentPage {
            cell.stepImage.image = UIImage(named: "ActiveStepHandleiding")
            cell.stepText.textColor = .white
            cell.stepText.font = UIFont(name: "AvenirNext-Medium", size: 26)
            if indexPath.row == viewControllers.count - 1 {
                cell.stepImage.image = UIImage(named: "activeReview")
            }
        }
        
        if indexPath.row != viewControllers.count-1 {
             cell.stepText.text = String(indexPath.row + 1)
        } else {
            cell.stepText.text = ""
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == currentPage {
            return CGSize(width: 44, height: 44)
        } else {
            return CGSize(width: 30, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gotToStep(step: indexPath.row)
    }
    
    func printCellAndViewSize() {
        print("width of the viewController \(view.frame.width) and cellsize \((view.frame.width/CGFloat(viewControllers.count)) - 1)")
    }
    
    @IBAction func closeGuide(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func gotToStep(step: Int) {
        scrollViewController.goToView(index: step)
    }

//
//    lazy var testViewController3: UIViewController! = {
//        return self.storyboard?.instantiateViewController(withIdentifier: "testViewController")
//    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let controller = segue.destination as? ScrollViewController {
            scrollViewController = controller
            scrollViewController.delegate = self
        }
    }
    
}



