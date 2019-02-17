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
    private var showingKennismaking = false
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
    @IBOutlet weak var hulpVragenView: UIView!
    
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
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showHulpView))
        hulpVragenView.addGestureRecognizer(tap)
        hulpVragenView.isUserInteractionEnabled = true

        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.tabBarController?.tabBar.isHidden = false
        
//        projectRef = db.collection("Projects").document("2ebbV5XVywZor78c2pty")
        
        if let latestProject = LastProject.shared.idLastProject {
            if latestProject != "" {
                projectRef = db.collection("Projects").document(latestProject)
            }
            
        }
        
        hacksCollectionRef = projectRef.collection("HacksInProject")
        kennismakingCollectionRef = projectRef.collection("Kennismaking")
        
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        setListener()
        
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "Projecten"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1),
             NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!]
        
        
        var backBtn = UIImage(named: "backButtonNavigation")
        backBtn = backBtn?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        self.navigationController!.navigationBar.backIndicatorImage = backBtn;
        self.navigationController!.navigationBar.backIndicatorTransitionMaskImage = backBtn;
        
        self.navigationController?.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1450980392, green: 0.2588235294, blue: 0.6156862745, alpha: 1),
                                                                                             NSAttributedString.Key.font: UIFont(name: "AvenirNext", size: 14.0)!], for: .normal)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1450980392, green: 0.2588235294, blue: 0.6156862745, alpha: 1),
             NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 16)!], for: .normal)
        
       
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
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
        
        if let projectRef = projectRef {
            var currentProject = Firestore.firestore().collection("Projects").document(LastProject.shared.idLastProject!)
            
            
            //Get project
            currentProject.getDocument() { (querysnapshot, err) in
                if let err = err {
                    print("no project found with \(LastProject.shared.idLastProject)")
                } else {
                    self.project = Project.parseOneData(snapshot: querysnapshot)
                }
            }
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        hackListener.remove()
        kennismakingListener.remove()
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
                kennisMakingViewCompleted.isHidden = true
            } else {
                kennisMakingHeight.constant = 590
                kennisMakingViewNotCompleted.isHidden = true
                kennisMakingViewCompleted.isHidden = false
            }
        } else {
            collapsIconKennismaking.image = UIImage(named: "arrowStepCollapsed")
            kennisMakingHeight.constant = 54
            kennisMakingViewNotCompleted.isHidden = true
            kennisMakingViewCompleted.isHidden = true
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
        
       if hacks.indices.contains(indexPath.row) {
        print("happend")
            let currenthack = hacks[indexPath.row]
        cell.setUpCell(titleHack: currenthack.name, currentStepHack: currenthack.currentStep, hackId: currenthack.hackId)
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        } else {
            cell.layoutbasic()
        }
        
        print(hacks)
//        cell.setUpCell(titleHack: hacks[indexPath.row].name, currentStepHack: hacks[indexPath.row].currentStep)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if hacks.indices.contains(indexPath.row) {
               let destionViewController = storyboard?.instantiateViewController(withIdentifier: "hackDetailProject") as! HackStartViewController
                destionViewController.hack = hacks[indexPath.row]
                destionViewController.referenceProject = projectRef
                self.navigationController?.show(destionViewController, sender: nil)
            }
            
    }
    
    
    private func scrollViewDidScroll(_ scrollView: ScalingCarouselView) {
        HacksInProjectCollectionView.didScroll()
        
        guard (HacksInProjectCollectionView.currentCenterCellIndex?.row) != nil else { return }
        
    }
    
    @IBAction func startKennismaking(_ sender: UIButton) {
        performSegue(withIdentifier: "showProjectDetail", sender: nil)
    }
    
    @objc private func showHulpView() {
//        if let project = project {
//            let hulpVraagView = storyboard?.instantiateViewController(withIdentifier: "hulpVraagView") as! HulpVragenViewController
//            hulpVraagView.project = project
//            self.navigationController?.pushViewController(hulpVraagView!, animated: true)
//        }
//        let hulpVraagView = storyboard?.instantiateViewController(withIdentifier: "hulpVraagView") as! HulpVragenViewController
        let hulpVraagView = storyboard?.instantiateViewController(withIdentifier: "hulpVraagView") as! HulpVragenViewController
        self.navigationController?.pushViewController(hulpVraagView, animated: true)
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
