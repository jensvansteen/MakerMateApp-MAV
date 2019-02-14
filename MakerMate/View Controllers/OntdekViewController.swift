//
//  OntdekViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 14/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

let cato = ["In de kijker", "Communicatie", "Eten & Drinken"]

class OntdekViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    @IBOutlet weak private var catoCollectionView: UICollectionView!
    
    @IBOutlet weak private var alshacksCollection: UICollectionView!
    
    private var hacks = [Hack]()
    
    private var db: Firestore!
    
    private var hacksCollectionRef: CollectionReference!
    private var hacksListener: ListenerRegistration!
    
    var searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        catoCollectionView.delegate = self
        catoCollectionView.dataSource = self
        alshacksCollection.delegate = self
        alshacksCollection.dataSource = self

        searchBar.placeholder = "Ontdek hacks"
        self.navigationItem.titleView = searchBar
        // Do any additional setup after loading the view.
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        hacksCollectionRef = db.collection("Hacks")
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
                self.alshacksCollection.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return cato.count
        } else if collectionView.tag == 1 {
            return hacks.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catooCell", for: indexPath) as! CatogorieCollectionViewCell
            cell.catogerieLabel.text = cato[indexPath.row]
            print(cato[indexPath.row])
            return cell
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hackiecell", for: indexPath) as! HackInOntdekCell
            cell.setUpCell(hack: hacks[indexPath.row])
            return cell
        } else {
            let cell = UICollectionViewCell()
            return cell
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
