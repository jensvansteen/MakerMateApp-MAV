//
//  hackTest.swift
//  MakerMate
//
//  Created by Jens Van Steen on 13/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import Firebase

class HackTest {
    
    var db: Firestore!
    
    private(set) static var sharedInstance = HackTest()
    
    
    private(set) var hackTested: Bool?
    var hackToTest: HackInProject?
    

    func pushToFirebase() {
        
        if let lastID = LastProject.shared.idLastProject {
            let settings = FirestoreSettings()
            Firestore.firestore().settings = settings
            // [END setup]
            db = Firestore.firestore()
            var ref: DocumentReference? = nil
            ref = db.collection("Projects").document("\(lastID)").collection("Kennismaking").addDocument(data: [
                "hackTested": true
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
    
    func setCurrentHackToTest() {
        if let hackToTest = hackToTest {
            hackToTest.updateHackAsTested()
            clearInstance()
        }
    }
    
    func hackWasTested() {
        self.hackTested = true
    }
    
    func clearInstance() {
        hackToTest = nil
    }
    
    
}
