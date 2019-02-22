//
//  HomeViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 30/01/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import ScalingCarousel
import Firebase
import FirebaseFirestore

var initialScrollDone = false;

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    let names = ["Marie-thérése", "Den bompa", "Anick"]
    
    private var projects = [Project]()
    private var requests = [Request]()
    private var projectsCollectionRef: CollectionReference!
    private var requestCollectionRef: CollectionReference!
    private var userCollectionRef: CollectionReference!
    private var projectListener: ListenerRegistration!
    private var requestListener: ListenerRegistration!
    private var userListener: ListenerRegistration!
    private var currentUser: User!
    private var project: Project?
    
    var db: Firestore!
    
    @IBOutlet private weak var nameProject: UILabel!
    @IBOutlet private weak var requestsCollectionView: UICollectionView!
    @IBOutlet private weak var projectsCollectionView: ScalingCarouselView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet weak var meerAanvraagButton: UIButton!
    @IBOutlet weak var aanvragenLabel: UILabel!
    @IBOutlet weak var actionButtonRecentProject: UIButton!
    @IBOutlet weak var hackvoorLabel: UILabel!
    @IBOutlet private weak var emptyStateLabel: UILabel!
    @IBOutlet private weak var emptyStateText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameProject.text = "Jeff"
        
        requestsCollectionView.delegate = self;
        requestsCollectionView.dataSource = self;
        projectsCollectionView.delegate = self;
        projectsCollectionView.dataSource = self;
        // Do any additional setup after loading the view.
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        projectsCollectionRef = db.collection("Projects")
        requestCollectionRef = db.collection("Requests")
        userCollectionRef = db.collection("Users")
        
        setupUI()
        
        setNavigationBar()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        requestsCollectionView.setContentOffset(CGPoint.zero, animated: true)
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
        setListener()
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    

    
    func setNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "Home"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1),
             NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!]
        
        self.navigationController?.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1450980392, green: 0.2588235294, blue: 0.6156862745, alpha: 1),
                                                                                             NSAttributedString.Key.font: UIFont(name: "AvenirNext", size: 14.0)!], for: .normal)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    func setListener() {
        requestListener = requestCollectionRef.addSnapshotListener { documentSnapshot, error in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            }  else {
                self.requests.removeAll()
                self.requests = Request.parseData(snapshot: documentSnapshot)
                self.requestsCollectionView.reloadData()
            }
        }
        
        let user = Auth.auth().currentUser!
        
        userListener = userCollectionRef.whereField("userID", isEqualTo: user.uid).addSnapshotListener { documentSnapshot, error in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            }  else {
                self.currentUser = User.parseData(snapshot: documentSnapshot)
                self.setupUI()
            }
        }
        
        projectListener = projectsCollectionRef.limit(to: 1).addSnapshotListener { documentSnapshot, error in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            }  else {
                self.projects.removeAll()
                guard let snap = documentSnapshot else {return }
                for document in snap.documents {
                    let data = document.data()
                    let idProject = document.documentID
                    print(idProject)
                    let project = Project(adress: data["adress"] as? String ?? "Main street", city: data["city"] as? String ?? "Kortrijk", description: data["description"] as? String ?? "Ik kan door mijn spierziekte geen beker vasthouden", descriptionShort: data["descriptionShort"] as? String ?? "Ik wil mijn paard kunnen borstelen", email: data["email"] as? String ?? "annickvercauteren@gmail.com", firstNameClient: data["firstNameClient"] as? String ?? "Réne", firstNameContact: data["firstNameContact"] as? String ?? "Réne", nameClient: data["nameClient"] as? String ?? "Vercauteren", nameContact: data["nameContact"] as? String ?? "Vercauteren", phonenumber: data["phonenumber"] as? Int ?? 04568456, targetGroup: data["targetGroup"] as? Int ?? 2, zip: data["zip"] as? String ?? "8500", projectId: idProject)
                    self.projects.append(project)
                }
                self.projectsCollectionView.reloadData()
            }
        }
        
        
        //        let currentProject = Firestore.firestore().collection("Projects").document(LastProject.shared.idLastProject!)
        //
        //        //Get project
        //        currentProject.getDocument() { (querysnapshot, err) in
        //            if let err = err {
        //                print("no project found with \(err)")
        //            } else {
        //                self.project = Project.parseOneData(snapshot: querysnapshot)
        //            }
        //        }
        //
        //
        setupUI()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        projectListener.remove()
        requestListener.remove()
        userListener.remove()
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        projectsCollectionView.deviceRotated()
    }
    
    
    func setupUI() {
        if let currentUser = currentUser {
            if currentUser.mate {
                meerAanvraagButton.setTitle("Toon alle aanvragen", for: .normal)
                actionButtonRecentProject.setTitle("Bekijk alle aanvragen", for: .normal)
                aanvragenLabel.text = "Aanvragen"
                nameProject.text = "Annick"
                if LastProject.shared.showProject {
                    actionButtonRecentProject.setTitle("Start de kennismaking", for: .normal)
                    nameProject.text = "Annick"
                }
            } else {
                aanvragenLabel.text = "Voorstellen"
                actionButtonRecentProject.setTitle("Bekijk alle voorstellen", for: .normal)
                meerAanvraagButton.setTitle("Toon alle voorstellen", for: .normal)
                if LastProject.shared.showProject {
                    actionButtonRecentProject.setTitle("Start de handleiding", for: .normal)
                    nameProject.text = "Annick"
                    nameProject.isHidden = true
                }
            }
            if LastProject.shared.showProject{
                hackvoorLabel.isHidden = true
                nameProject.isHidden = false
                emptyStateText.isHidden = true
                emptyStateLabel.isHidden = true
                hackvoorLabel.isHidden = false
            } else {
                nameProject.text = "Annick"
                nameProject.isHidden = true
                emptyStateText.isHidden = false
                emptyStateLabel.isHidden = false
                hackvoorLabel.isHidden = true
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return requests.count
        } else if collectionView.tag == 2 {
            if LastProject.shared.showProject {
                return projects.count + 1
            } else {
                return 1
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "requestCell", for: indexPath) as! RequestCell
            if requests.count >= 1 {
                cell.setUp(request: requests[indexPath.row])
            }
            return cell
        } else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! ProjectCollectionViewCell
            if indexPath.row == 0 {
                print("hello")
            }
            
            if indexPath.row < projects.count && LastProject.shared.showProject {
                cell.layoutProject(project: projects[indexPath.row], mate: currentUser.mate)
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
            } else {
                cell.layoutStart()
            }
            
            return cell
        } else {
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 2 {
            if indexPath.row == projects.count || !LastProject.shared.showProject {
                performSegue(withIdentifier: "makeRequest", sender: nil)
            } else {
                self.tabBarController!.selectedIndex = 1
            }
        }
    }
    
    private func scrollViewDidScroll(_ scrollView: ScalingCarouselView) {
        projectsCollectionView.didScroll()
        
        guard (projectsCollectionView.currentCenterCellIndex?.row) != nil else { return }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowRequest" {
            let toVC = segue.destination as! RequestViewController
            if let cell = sender as? RequestCell,
                let selectedRequest = self.requestsCollectionView.indexPath(for: cell) {
                toVC.request = requests[selectedRequest.row]
            }
        }
        
    }
    
    @IBAction func performAction(_ sender: UIButton) {
        if LastProject.shared.showProject {
            self.tabBarController!.selectedIndex = 1
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


