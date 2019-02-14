//
//  Hack.swift
//  MakerMate
//
//  Created by Jens Van Steen on 06/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import UIKit

class HackInProject {
    
    var db: Firestore!
    
    private(set) var likes: Int
    private(set) var niveau: Int
    private(set) var currentStep: Int
    private(set) var name: String
    private(set) var hackId: String
    private(set) var projectId: String
    private(set) var hackImage: UIImage?
    var hackTested: Bool
    var hackEvaluated: Bool
    var readyForTesting: Bool!
    
    init(likes: Int, niveau: Int, currentStep: Int, name: String, hackId: String, projectId: String, hackTested: Bool, hackEvaluated: Bool) {
        self.likes = likes
        self.niveau = niveau
        self.currentStep = currentStep
        self.name = name
        self.hackId = hackId
        self.projectId = projectId
        self.hackTested = hackTested
        self.hackEvaluated = hackEvaluated
        self.readyForTesting = false
        
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
    
    
    func updateHackAsTested() {
        self.hackTested = true
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        ref = db.collection("Projects").document(projectId)
        let documenref = ref!.collection("HacksInProject").document("\(self.hackId)")
        
        documenref.updateData([
            "hackTested": true
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    func updateHackAsEvaluated() {
        
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [HackInProject] {
        var hacks = [HackInProject]()
        
        guard let snap = snapshot else {return hacks}
        for document in snap.documents {
            let data = document.data()
            let id = document.documentID
            let projecto = data["projectId"] as! String
            let hack = HackInProject(likes: data["likes"] as? Int ?? 0, niveau: data["niveau"] as? Int ?? 0, currentStep: data["currentStep"] as? Int ?? 0, name: data["name"] as? String ?? "Hello", hackId: id, projectId: (data["projectId"] as? String)!, hackTested: data["hackTested"] as! Bool, hackEvaluated: data["hackEvaluated"] as! Bool)
            hacks.append(hack)
        }
        
        return hacks
    }
    
}
