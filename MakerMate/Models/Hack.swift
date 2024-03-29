//
//  Hack.swift
//  MakerMate
//
//  Created by Jens Van Steen on 10/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import UIKit


class Hack {
    
    var db: Firestore!
    
    private(set) var name: String
    private(set) var likes: Int
    private(set) var niveau: Int
    private(set) var hackId: String
    private(set) var hackShortTitle: String
    private(set) var hackImage: UIImage?
  
    
    
    init(likes: Int, niveau: Int, name: String, hackId: String, hackShortTitle: String) {
        self.likes = likes
        self.niveau = niveau
        self.name = name
        self.hackId = hackId
        self.hackShortTitle = hackShortTitle
       
        
        self.getHackImage(hackId: hackId)
    }
    
    private func getHackImage(hackId: String) {
        
        let referenceToStorage = Storage.storage()
        
        let gsReference = referenceToStorage.reference(forURL: "gs://makermate-a22cc.appspot.com/hacks/\(hackId)/imageHack.jpg")
        
        gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("the error is \(error)")
            } else {
                let image = UIImage(data: data!)
                self.hackImage = image
                
            }
        }
        
    }
    
    func addToProject(projectId: String) {
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        var refProject: DocumentReference? = nil
        var refHackInProject: DocumentReference? = nil
        
        refProject = db.collection("Projects").document(projectId)
        refHackInProject = refProject?.collection("HacksInProject").addDocument(data: [
            "likes": self.likes,
            "niveau": self.niveau,
            "name": self.name,
            "referenceToHackId": self.hackId,
            "currentStep": 1,
            "projectId": projectId,
            "hackTested": false,
            "hackShortTitle": self.hackShortTitle,
            "hackEvaluated": false
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("hackAddedToProject added with ID: \(refProject!.documentID)")
                let referenceToHacksinProject = refProject?.collection("HacksInProject").document(refHackInProject!.documentID)
                let referenceStepsInHack = self.db.collection("Hacks").document(self.hackId)
                let stepCollectionInHack = referenceStepsInHack.collection("Steps")
                
                stepCollectionInHack.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents")
                    } else {
                        for step in querySnapshot!.documents {
                            let data = step.data()
                            let idStep = step.documentID
                            var referenceToStepsInProject: DocumentReference? = nil
                            
                            referenceToStepsInProject = referenceToHacksinProject?.collection("Steps").addDocument(data: [
                                "description": data["description"] as! String,
                                "order": data["order"] as! Int,
                                "projectId": projectId,
                                "orginalHackId": self.hackId,
                                "hackId": refHackInProject!.documentID,
                                "photoAdjusted": false
                            ]) { err in
                                if let err = err {
                                    print("Error adding document: \(err)")
                                } else {
                                    print(referenceToStepsInProject!.documentID)
                                    let stepItemsAdd = referenceToHacksinProject?.collection("Steps").document(referenceToStepsInProject!.documentID)
                                    stepItemsAdd?.updateData([
                                        "items": data["items"] as! [String]
                                        ])
                                    { err in
                                        if let err = err {
                                            print("Error updating items: \(err)")
                                        } else {
                                            print("document succesfully transported")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    
    class func parseData(snapshot: QuerySnapshot?) -> [Hack] {
        var hacks = [Hack]()
        
        guard let snap = snapshot else {return hacks}
        for document in snap.documents {
            let data = document.data()
            let id = document.documentID
            print(data)
            let name = data["name"] as! String
            let likes = data["likes"] as! Int
            let niveau = data["niveau"] as! Int
            let hackShortTitle = data["hackShortTitle"] as! String
            let hack = Hack(likes: likes, niveau: niveau, name: name, hackId: id, hackShortTitle: hackShortTitle)
            hacks.append(hack)
        }
        
        return hacks
    }
    
    
    
    
    
    
    
    
}
