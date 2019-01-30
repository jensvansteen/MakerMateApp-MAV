//
//  HomeViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 30/01/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import ScalingCarousel

var initialScrollDone = false;

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    let names = ["Marie-thérése", "Den bompa", "Anick"]
 
    @IBOutlet weak var nameProject: UILabel!
    @IBOutlet weak var requestsCollectionView: UICollectionView!
    @IBOutlet weak var projectsCollectionView: ScalingCarouselView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameProject.text = "Jeff"
        
        requestsCollectionView.delegate = self;
        requestsCollectionView.dataSource = self;
        projectsCollectionView.delegate = self;
        projectsCollectionView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        projectsCollectionView.deviceRotated()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return names.count
        } else if collectionView.tag == 2 {
            return 3
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "requestCell", for: indexPath) as! RequestCell
            cell.nameRequest.text = names[indexPath.row]
            print(names[indexPath.row])
            return cell
        } else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! ProjectCollectionViewCell
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            
            if let scalingCell = cell as? ProjectCollectionViewCell {
                scalingCell.layoutViews(project: true, projectName: "Annick", projectStep: "Prototyping")
            }
            
            DispatchQueue.main.async {
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
            }
            
            return cell
        } else {
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    private func scrollViewDidScroll(_ scrollView: ScalingCarouselView) {
        projectsCollectionView.didScroll()
        
        guard (projectsCollectionView.currentCenterCellIndex?.row) != nil else { return }
        
    }
    
    
    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //carousel.didScroll()
        
        
        
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


