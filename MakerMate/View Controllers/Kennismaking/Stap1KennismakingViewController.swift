//
//  Stap1KennismakingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 09/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class Stap1KennismakingViewController: UIViewController {
    
    
     var db: Firestore!
    
     private var hacksCollectionRef: CollectionReference!
     private var hackListener: ListenerRegistration!
     private var hacks = [Hack]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        hacksCollectionRef = db.collection("Hacks")
        
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
                self.hacks = Hack.parseData(snapshot: documentSnapshot)
                print(self.hacks)
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
    @IBAction func afrondenKennismaking(_ sender: Any) {
        
        kennismakingSteps.sharedInstance.stap1(mobiliteitsKlasse: 2)
        
        hacks[0].addToProject(projectId: LastProject.shared.idLastProject!)
        
        kennismakingSteps.sharedInstance.pushToFirebase()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
