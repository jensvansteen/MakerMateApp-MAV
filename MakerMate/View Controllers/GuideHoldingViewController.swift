//
//  GuideHoldingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 04/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class GuideHoldingViewController: UIViewController, ScrollViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var initialViewController: Int = 0
    
    var viewControllers: [TestViewController?] = []

    let viewControllerData = [0,1,2, 3, 5, 6]
    
    var widthOneCell: CGFloat = 0.0
    
    var updateCell = BottomStepIndecatorCollectionViewCell()
    
    var scrollViewController: ScrollViewController!
    
    var firstTimeLoading = false
    
    @IBOutlet weak var stepIndecatorCollectionView: UICollectionView!
    
    @IBOutlet weak var spacingLeftStepIndecator: NSLayoutConstraint!
    
    @IBOutlet weak var viewHolderCollectionView: UIView!
    public var currentPage: Int = 0 {
        didSet {
//            indexPageLabel.text = String(currentPage)
            let indexPath = IndexPath(row: currentPage, section: 0)
            if firstTimeLoading {
                updateCell.stepImage.image = UIImage(named: "NonActiveStep")
                updateCell.stepText.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.1960784314, alpha: 1)
            }
            stepIndecatorCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            updateCell = stepIndecatorCollectionView.cellForItem(at: indexPath) as! BottomStepIndecatorCollectionViewCell
            updateCell.stepImage.image = UIImage(named: "ActiveStepHandleiding")
            updateCell.stepText.textColor = .white
            firstTimeLoading = true
        }
    }
    
    public var currentCoordinationPointHolder: CGFloat = 0 {
        didSet {
            print("Helllloooooooooo")
            spacingLeftStepIndecator.constant = currentCoordinationPointHolder/CGFloat(-viewControllers.count) + view.frame.width/2 + 30
//            let visibleRect = CGRect(x: viewHolderCollectionView.frame.midX, y: viewHolderCollectionView.frame.midY, width: 60, height: 40)
//            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//            let visibleIndexPath = stepIndecatorCollectionView.indexPathForItem(at: CGPoint(x: view.frame.width/2, y: view.frame.height - 30))
//            print("the visible path is \(visibleIndexPath)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeSteps()
        
        stepIndecatorCollectionView.delegate = self
        stepIndecatorCollectionView.dataSource = self
        
//        indexPageLabel.text = String(initialViewController)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        printCellAndViewSize()
        
//        currentIndex = delegate?.currentIndex
    }
    
  
    func makeSteps() {
        var viewControllersColl: [TestViewController] = []
        for step in viewControllerData {
            let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "testViewController") as! TestViewController
            viewControllersColl.append(viewCon)
        }
        
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
        
        
        if indexPath.row == initialViewController {
            cell.stepImage.image = UIImage(named: "ActiveStepHandleiding")
            cell.stepText.textColor = .white
        }
        
      
       cell.stepText.text = String(indexPath.row + 1)
        return cell
    }
    
    func printCellAndViewSize() {
        print("width of the viewController \(view.frame.width) and cellsize \((view.frame.width/CGFloat(viewControllers.count)) - 1)")
    }
    
    @IBAction func closeGuide(_ sender: UIButton) {
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



