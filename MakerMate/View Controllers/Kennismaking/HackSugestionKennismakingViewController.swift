//
//  HackSugestionKennismakingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 11/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class HackSugestionKennismakingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
    @IBOutlet weak private var hackCollectionView: UICollectionView!
    @IBOutlet weak private var closeView: UIImageView!
    private var hacks = [Hack]()
    
     private var db: Firestore!
    
     private var hacksCollectionRef: CollectionReference!
     private var hacksListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hackCollectionView.delegate = self
        hackCollectionView.dataSource = self
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        hacksCollectionRef = db.collection("Hacks")

        // Do any additional setup after loading the view.
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        closeView.addGestureRecognizer(tapDismiss)
        closeView.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        hacksListener.remove()
        
    }
    
    private func setListener() {
        hacksListener = hacksCollectionRef.whereField("likes", isEqualTo: 6).limit(to: 4).addSnapshotListener { documentSnapshot, error in
            if let err = error {
                debugPrint("Error fetching docs: \(error)")
            } else {
                self.hacks.removeAll()
                self.hacks = Hack.parseData(snapshot: documentSnapshot)
                self.hackCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hacks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hackPreviewKennismaking", for: indexPath) as! HackPreviewCollectionViewCell
        cell.setUpCell(hack: hacks[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showHackDetailKennis", sender: indexPath)
    }
    

    
    @objc private func handleDismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "showHackDetailKennis" {
//        if let cell = sender as? HackPreviewCollectionViewCell,
//            let indexPath = self.hackCollectionView.indexPath(for: cell) {
//
//            let vc = segue.destination as! HackDetailKennismakingViewController //Cast with your DestinationController
//            //Now simply set the title property of vc
//            vc.hack = hacks[indexPath.row]
//        }
//    }
        
        
        if segue.identifier == "showHackDetailKennis"{
            
            let selectedIndexPath = sender as? NSIndexPath
            print(hacks[selectedIndexPath!.row])
            let detailVC = segue.destination as! HackDetailKennismakingViewController
            detailVC.hack = hacks[selectedIndexPath!.row] as Hack
        }
    }
    

}
