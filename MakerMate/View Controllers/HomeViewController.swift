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
    private var projectsCollectionRef: CollectionReference!
    
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
        
        projectsCollectionRef = Firestore.firestore().collection("Projects")
        
        
        showFireBaseData()
    }
    
  
    func showFireBaseData() {
        db.collection("Projects").addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                let source = document.metadata.hasPendingWrites ? "Local" : "Server"
                print("\(source)")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        projectsCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(error)")
            } else {
                guard let snap = snapshot else {return}
                for document in snap.documents {
                    print(document.data())
                    let data = document.data()
                    let project = Project(name: data["name"] as! String, firstName: data["firstName"] as! String, email: data["email"] as! String, phoneNumber: data["phoneNumber"] as! Int, adress: data["adress"] as! String, city: data["city"] as! String, province: data["province"] as! String, zip: data["zip"] as! Int, wish: data["wish"] as! String, description: data["description"] as! String, targetGroup: data["targetGroup"] as! String)
                    self.projects.append(project)
                }
                self.projectsCollectionView.reloadData()
            }
        }
        
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        projectsCollectionView.deviceRotated()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return names.count
        } else if collectionView.tag == 2 {
            return projects.count + 1
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "requestCell", for: indexPath) as! RequestCell
            cell.nameRequest.text = names[indexPath.row]
            cell.collectionViewData = ["Dieren", "Winkelen", "Iets gaan drinken"]
            print(names[indexPath.row])
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
            
            if let cell = sender as? RequestCell,
                let _ = self.requestsCollectionView.indexPath(for: cell) {
                
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


