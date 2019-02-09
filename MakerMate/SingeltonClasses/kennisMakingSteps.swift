//
//  kennisMakingSteps.swift
//  MakerMate
//
//  Created by Jens Van Steen on 09/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class kennismakingSteps {
    
    
    var db: Firestore!
    
    private(set) static var sharedInstance = kennismakingSteps()
    
    
      private(set) var mobiliteitsKlasse: Int?
      private(set) var currentProject: String?
    
    
    
    func stap1(mobiliteitsKlasse: Int) {
        self.mobiliteitsKlasse = mobiliteitsKlasse
    }
    
    
    
    func pushToFirebase() {
        
        if let lastID = LastProject.shared.idLastProject {
            let settings = FirestoreSettings()
            Firestore.firestore().settings = settings
            // [END setup]
            db = Firestore.firestore()
            var ref: DocumentReference? = nil
            ref = db.collection("Projects").document("\(lastID)").collection("Kennismaking").addDocument(data: [
                "mobiliteitsKlasse": mobiliteitsKlasse
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
            
            clearInstance()
        } else {
            return
        }
       
    }
    
    
    private func clearInstance() {
        mobiliteitsKlasse = nil
    }
    
}
