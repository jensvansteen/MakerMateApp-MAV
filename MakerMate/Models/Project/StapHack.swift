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
    var hackId: String?
    var projectId: String?
    private(set) var order: Int
    
    
    init(description: String, items: [String], stepId: String, order: Int) {
        self.description = description
        self.items = items
        self.stepId = stepId
        self.order = order
        
    }
    
    
    func getStepImage(hackId: String) {
        
        self.hackId = hackId
        
        let referenceToStorage = Storage.storage()
        
        let gsReference = referenceToStorage.reference(forURL: "gs://makermate-a22cc.appspot.com/hacksSteps/\(hackId)/stap\(order).jpg")
        
        gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("the error is \(error)")
            } else {
                let image = UIImage(data: data!)
                self.stepImage = image
            }
        }
        
    }
    
    func updateDescription(text: String, projectReference: DocumentReference) {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        
        
        let documenref = projectReference.collection("HacksInProject").document("\(self.hackId!)")
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
    
    func updateItems(items: [String], projectReference: DocumentReference) {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        
        let documenref = projectReference.collection("HacksInProject").document("\(self.hackId!)")
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
            var stapInHandleiding = StapHack(description: descriptionText, items: itemsStep, stepId: id, order: orderStep)
            staps.append(stapInHandleiding)
        }
        
        return staps
    }
    
}
