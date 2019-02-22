//
//  Invite.swift
//  MakerMate
//
//  Created by Jens Van Steen on 12/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import Firebase


class Invite {
    
    var db: Firestore!
    
    private(set) var projectId: String?
    private(set) var id: String
    
    init(projectId: String, id: String) {
        self.projectId = projectId
        self.id = id
    }
    
    
    func pushInvitation() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        var refInvite: DocumentReference? = nil
        
        if let projectId = self.projectId {
            refInvite = db.collection("Invites").addDocument(data: [
                "projectId": projectId
            ]) {err in
                if let err = err {
                    print("Error adding document: \(err)")
                }
            }
        }
    }
    
    func acceptInvite() {
        db.collection("Invites").document(id).delete() { err in
            if let err = err {
                print("error removing document")
            } else {
                print("Document succesfully removed")
            }
        }
    }
    
    
    class func parseData(snapshot: QuerySnapshot?) -> Invite {
        var invite: Invite?
        
        guard let snap = snapshot else {return invite!}
        for document in snap.documents {
            let data = document.data()
            let id = document.documentID
            print(data)
            let projectid = data["projectId"] as! String
            let deInvite = Invite(projectId: projectid, id: id)
            invite  = deInvite
        }
        
        return invite!
    }
    
}
