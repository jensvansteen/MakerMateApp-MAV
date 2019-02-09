//
//  ProjectViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 03/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import ScalingCarousel
import Firebase
import FirebaseFirestore

class ProjectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
//    var hacks = ["Zip-Aid", "DIY Lighter aid"]
    
    private var project: Project?
    private var kennismakingProject: Kennismaking?
    private var hacks = [HackInProject]()
    private var hacksCollectionRef: CollectionReference!
    private var kennismakingCollectionRef: CollectionReference!
    private var projectRef: DocumentReference!
    private var hackListener: ListenerRegistration!
    private var kennismakingListener: ListenerRegistration!
    
    var currentStep = "Kennismaking"
    private var showingAanvraag = true
    private var showingKennismaking = true
    private var showingHacks = false
    private var kennisMakingCompleted = true
    
    var db: Firestore!
    
    
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
    @IBOutlet weak var kennisMakingViewCompleted: KennisMakingDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HacksInProjectCollectionView.delegate = self
        HacksInProjectCollectionView.dataSource = self
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
       
        
        setupTaps()
        configureViews()
        
        
        projectRef = db.collection("Projects").document("m9jD7xXwE1Yza3xcKBCM")
        
//        if let latestProject = LastProject.shared.idLastProject {
//            if latestProject != "" {
//                 projectRef = db.collection("Projects").document(latestProject)
//            }
//
//        }
        

        hacksCollectionRef = projectRef.collection("HacksInProject")
        kennismakingCollectionRef = projectRef.collection("Kennismaking")
        
        
        
//        var projectYannick = Firestore.firestore().collection("Projects").document("1Hoa2D5bUxbFsbVxdVXZ").
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        // Hide the Navigation Bar
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setListener()
        
    
    }
    
    
    func setListener() {
        hackListener = hacksCollectionRef.addSnapshotListener { documentSnapshot, error in
            if let err = error {
                debugPrint("Error fetching docs: \(error)")
            }  else {
                self.hacks.removeAll()
                self.hacks = HackInProject.parseData(snapshot: documentSnapshot)
                self.HacksInProjectCollectionView.reloadData()
            }
        }
        
        
        kennismakingListener = kennismakingCollectionRef.addSnapshotListener { documentSnapshot, error in
            if documentSnapshot!.isEmpty == false {
                if let err = error {
                    debugPrint("Error fetching docs: \(error)")
                }  else {
                    self.kennismakingProject = Kennismaking.parseData(snapshot: documentSnapshot)
                    self.kennisMakingCompleted = true
                    self.configureViews()
                }
            } else {
                self.kennisMakingCompleted = false
                self.configureViews()
            }
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        hackListener.remove()
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
            kennisMakingViewNotCompleted.isHidden = true
            kennisMakingViewCompleted.isHidden = false
            indecatorKennismakingImage.image = UIImage(named: "projectStepDone")
            indecatorHacksImage.isHidden = false
        } else {
            kennisMakingViewNotCompleted.isHidden = false
            kennisMakingViewCompleted.isHidden = true
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
        
        print(hacks)
//        cell.setUpCell(titleHack: hacks[indexPath.row].name, currentStepHack: hacks[indexPath.row].currentStep)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(hacks[indexPath.row].productId)
//        performSegue(withIdentifier: "GoToHack", sender: nil)
    }
    
    private func scrollViewDidScroll(_ scrollView: ScalingCarouselView) {
        HacksInProjectCollectionView.didScroll()
        
        guard (HacksInProjectCollectionView.currentCenterCellIndex?.row) != nil else { return }
        
    }
    
    @IBAction func startKennismaking(_ sender: UIButton) {
        performSegue(withIdentifier: "showProjectDetail", sender: nil)
    }
    

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProjectDetail" {
//            let nv = segue.destination as! UINavigationController
//            let vc = nv.viewControllers.first as! StepsProjectViewController
//            vc.currentProjectID =
            //true and false fase project
        }
        
        
     }
 
    
}
