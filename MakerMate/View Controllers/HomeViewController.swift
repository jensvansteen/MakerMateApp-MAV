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
    private var projectListener: ListenerRegistration!
    private var requestListener: ListenerRegistration!
    private var currentUser: User!
    
    var db: Firestore!
 
    @IBOutlet private weak var nameProject: UILabel!
    @IBOutlet private weak var requestsCollectionView: UICollectionView!
    @IBOutlet private weak var projectsCollectionView: ScalingCarouselView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentView: UIView!
    
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
        
          let user = Auth.auth().currentUser!
        
        
        print("The current user as the id \(user.uid) and the displayname:(\(user.displayName))")
        
//        var projectYannick = Firestore.firestore().collection("Projects").document("1Hoa2D5bUxbFsbVxdVXZ")
//        projectYannick.getDocument { (document,error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data()
//                print(dataDescription)
//            } else {
//                print("data does not exsist")
//            }
//        }
        
       
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        


        setListener()
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func setListener() {
        projectListener = projectsCollectionRef.addSnapshotListener { documentSnapshot, error in
            if let err = error {
                debugPrint("Error fetching docs: \(error)")
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
        
        requestListener = requestCollectionRef.addSnapshotListener { documentSnapshot, error in
            if let err = error {
                debugPrint("Error fetching docs: \(error)")
            }  else {
                self.requests.removeAll()
                self.requests = Request.parseData(snapshot: documentSnapshot)
                self.requestsCollectionView.reloadData()
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        projectListener.remove()
        requestListener.remove()
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        projectsCollectionView.deviceRotated()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return requests.count
        } else if collectionView.tag == 2 {
            return projects.count + 1
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
            
            if indexPath.row < projects.count {
                cell.layoutProject(project: projects[indexPath.row])
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
            if indexPath.row == projects.count {
                performSegue(withIdentifier: "makeRequest", sender: nil)
            }
            
        }
    }
    
    private func scrollViewDidScroll(_ scrollView: ScalingCarouselView) {
        projectsCollectionView.didScroll()
        
        guard (projectsCollectionView.currentCenterCellIndex?.row) != nil else { return }
        
    }
    
    
    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //carousel.didScroll()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowRequest" {
            let toVC = segue.destination as! RequestViewController
            if let cell = sender as? RequestCell,
                let selectedRequest = self.requestsCollectionView.indexPath(for: cell) {
                   toVC.request = requests[selectedRequest.row]
            }
            
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


