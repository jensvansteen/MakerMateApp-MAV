//
//  ProjectViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 03/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import ScalingCarousel

class ProjectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    var hacks = ["Zip-Aid", "DIY Lighter aid"]

    var currentStep = "Kennismaking"
    private var showingAanvraag = true
    private var showingKennismaking = true
    private var showingHacks = false
    private var kennisMakingCompleted = true
    
    @IBOutlet weak var contentViewHolder: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var HacksInProjectCollectionView: ScalingCarouselView!
    @IBOutlet weak private var headerViewAanvraag: UIView!
    @IBOutlet weak var contentAanvraagView: UIView!
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var aanVraagHeight: NSLayoutConstraint!
    @IBOutlet weak var kennisMakingHeight: NSLayoutConstraint!
    @IBOutlet weak var headerKennismakingVIew: UIView!
    @IBOutlet weak var hacksHeight: NSLayoutConstraint!
    @IBOutlet weak var headerHacksView: UIView!
    @IBOutlet weak var kennisMakingViewNotCompleted: UIView!
    @IBOutlet weak var indecatorAanvraagImage: UIImageView!
    @IBOutlet weak var collapsIconAanvraagImage: UIImageView!
    @IBOutlet weak var indecatorKennismakingImage: UIImageView!
    @IBOutlet weak var collapsIconKennismaking: UIImageView!
    @IBOutlet weak var indecatorHacksImage: UIImageView!
    @IBOutlet weak var collapsIconHacksImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        HacksInProjectCollectionView.delegate = self
        HacksInProjectCollectionView.dataSource = self
        
        setupTaps()
        configureViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupTaps() {
        let tapAanvraag = UITapGestureRecognizer(target: self, action: #selector(showAanvraag))
        headerViewAanvraag.addGestureRecognizer(tapAanvraag)
        headerViewAanvraag.isUserInteractionEnabled = true
        
        let tapKennismaking = UITapGestureRecognizer(target: self, action: #selector(showKennismaking))
        headerKennismakingVIew.addGestureRecognizer(tapKennismaking)
        headerKennismakingVIew.isUserInteractionEnabled = true
        
        let tapHacks = UITapGestureRecognizer(target: self, action: #selector(showHacks))
        headerHacksView.addGestureRecognizer(tapHacks)
        headerHacksView.isUserInteractionEnabled = true
    }
    
    func configureViews() {
        if showingAanvraag {
            collapsIconAanvraagImage.image = UIImage(named: "arrowStepOpen")
            aanVraagHeight.constant = 174
        } else {
            collapsIconAanvraagImage.image = UIImage(named: "arrowStepCollapsed")
            aanVraagHeight.constant = 54
        }
        
        if showingKennismaking {
            collapsIconKennismaking.image = UIImage(named: "arrowStepOpen")
            if kennisMakingCompleted == false {
                kennisMakingHeight.constant = 372
                kennisMakingViewNotCompleted.isHidden = false
                
            } else {
                kennisMakingHeight.constant = 741
                kennisMakingViewNotCompleted.isHidden = true
            }
        } else {
            collapsIconKennismaking.image = UIImage(named: "arrowStepCollapsed")
            kennisMakingHeight.constant = 54
            kennisMakingViewNotCompleted.isHidden = true
        }
        
        if showingHacks {
            collapsIconHacksImage.image = UIImage(named: "arrowStepOpen")
            hacksHeight.constant = 430
            HacksInProjectCollectionView.isHidden = false
        } else {
            collapsIconHacksImage.image = UIImage(named: "arrowStepCollapsed")
            hacksHeight.constant = 54
            HacksInProjectCollectionView.isHidden = true
        }
        
        if kennisMakingCompleted {
            indecatorKennismakingImage.image = UIImage(named: "projectStepDone")
            indecatorHacksImage.isHidden = false
        } else {
            indecatorKennismakingImage.image = UIImage(named: "projectStepToDo")
            indecatorHacksImage.isHidden = true
        }
        
        
        calculateScrollViewAndUpdate()
    }
    
    func calculateScrollViewAndUpdate() {
        let totalHeightViews = hacksHeight.constant + kennisMakingHeight.constant + aanVraagHeight.constant + 200
        print("update scrollView to height of \(totalHeightViews)")
        print("height of viewcontroller is \(view.frame.height)")
        if totalHeightViews < view.frame.height {
            contentViewHeight.constant = view.frame.height - 50
        } else {
            contentViewHeight.constant = totalHeightViews
        }
    }
    
    
    @objc func showAanvraag() {
        print("aanvraagPressed")
        showingAanvraag = !showingAanvraag
        configureViews()
    }
    
    @objc func showKennismaking() {
        print("kennismaking pressed")
        showingKennismaking = !showingKennismaking
        configureViews()
    }
    
    @objc func showHacks() {
        print("hacks pressed")
        if kennisMakingCompleted {
            showingHacks = !showingHacks
        }
        configureViews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        HacksInProjectCollectionView.deviceRotated()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hacks.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hackCell", for: indexPath) as! HackInProjectCollectionViewCell
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    private func scrollViewDidScroll(_ scrollView: ScalingCarouselView) {
        HacksInProjectCollectionView.didScroll()
        
        guard (HacksInProjectCollectionView.currentCenterCellIndex?.row) != nil else { return }
        
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
