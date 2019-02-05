//
//  GuideHoldingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 04/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class GuideHoldingViewController: UIViewController, ScrollViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var initialViewController: Int = 0
    
    var viewControllers: [TestViewController?] = []

    let viewControllerData = [0,1,2, 3, 5, 6]
    
    var widthOneCell: CGFloat = 0.0
    
    var scrollViewController: ScrollViewController!
    
    @IBOutlet weak var stepIndecatorTopCollectionView: UICollectionView!
    
    @IBOutlet weak var indexPageLabel: UILabel!
    
    public var currentPage: Int = 0 {
        didSet {
            indexPageLabel.text = String(currentPage)
            stepIndecatorTopCollectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepIndecatorTopCollectionView.delegate = self
        stepIndecatorTopCollectionView.dataSource = self
        
        makeSteps()
        
        indexPageLabel.text = String(initialViewController)
        
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
        
        self.stepIndecatorTopCollectionView.reloadData()
        
        print("cell size is \(widthOneCell)")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stepCell", for: indexPath)
        
        if indexPath.row == currentPage {
            cell.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthViewController = view.frame.width
        
        print("width of the viewController \(widthViewController)")
        
        widthOneCell = (widthViewController/CGFloat(viewControllers.count)) - 1
        
        
        
        return CGSize(width: widthOneCell, height: 8)
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



