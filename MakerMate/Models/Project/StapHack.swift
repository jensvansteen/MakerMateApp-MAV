//
//  StapHack.swift
//  MakerMate
//
//  Created by Jens Van Steen on 09/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class StapHack {
    
     var db: Firestore!
    
    private(set) var description: String
    private(set) var items: [String]?
    private(set) var stepImage: UIImage?
    private(set) var stepId: String
    private(set) var hackId: String?
    private(set) var projectId: String?
    private(set) var orginalHackId: String?
    private(set) var photoAdjusted: Bool?
    private(set) var order: Int
    
    
    init(description: String, items: [String], stepId: String, order: Int, hackId: String, projectId: String, orginalHackId: String, photoAdjusted: Bool) {
        self.description = description
        self.items = items
        self.order = order
        self.stepId = stepId
        self.hackId = hackId
        self.projectId = projectId
        self.orginalHackId = orginalHackId
        self.photoAdjusted = photoAdjusted
        
        getStepImage(hackId: hackId)
    }
    
    
    private func getStepImage(hackId: String) {
        
        let referenceToStorage = Storage.storage()
        
        var gsReference: StorageReference!
        
        if photoAdjusted == true {
            gsReference = referenceToStorage.reference(forURL: "gs://makermate-a22cc.appspot.com/hackSteps/\(hackId)/stap\(order).jpg")
        } else {
                gsReference = referenceToStorage.reference(forURL: "gs://makermate-a22cc.appspot.com/hackSteps/\(orginalHackId!)/stap\(order).jpg")
        }
        
        gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("the error is \(error)")
            } else {
                let image = UIImage(data: data!)
                self.stepImage = image
            }
        }
        
    }
    
    func photoAdjustedForHack() {
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        ref = db.collection("Projects").document(projectId!)
        let documenref = ref!.collection("HacksInProject").document("\(self.hackId!)")
        let documentUpdate = documenref.collection("Steps").document(self.stepId)
        
        documentUpdate.updateData([
            "photoAdjusted": true
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.getStepImage(hackId: self.hackId!)
            }
        }
        
    }
    
    func updateDescription(text: String) {
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        ref = db.collection("Projects").document(projectId!)
        let documenref = ref!.collection("HacksInProject").document("\(self.hackId!)")
        let documentUpdate = documenref.collection("Steps").document(self.stepId)
        
        documentUpdate.updateData([
            "description": text
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    func updateItems(items: [String]) {
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        ref = db.collection("Projects").document(projectId!)
        let documenref = ref!.collection("HacksInProject").document("\(self.hackId!)")
        let documentUpdate = documenref.collection("Steps").document(self.stepId)
        
        documentUpdate.updateData([
            "items": items
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [StapHack] {
        var staps = [StapHack]()
        
        guard let snap = snapshot else {return staps}
        for document in snap.documents {
            let data = document.data()
            let id = document.documentID
            print(data)
            let descriptionText = data["description"] as! String
            let itemsStep = data["items"] as! [String]
            let orderStep = data["order"] as? Int ?? 1
            let hackId = data["hackId"] as! String
            let projectId = data["projectId"] as! String
            let orginalHackId = data["orginalHackId"] as! String
            let photoAdjusted = data["photoAdjusted"] as! Bool
            let stapInHandleiding = StapHack(description: descriptionText, items: itemsStep, stepId: id, order: orderStep, hackId: hackId, projectId: projectId, orginalHackId: orginalHackId, photoAdjusted: photoAdjusted)
            staps.append(stapInHandleiding)
        }
        
        return staps
    }
    
}
