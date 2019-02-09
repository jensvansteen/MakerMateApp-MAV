//
//  Project.swift
//  MakerMate
//
//  Created by Jens Van Steen on 03/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore


struct Project {
    
    private(set) var db: Firestore!
    
    private(set) var adress: String?
    private(set) var city: String?
    private(set) var description: String?
    private(set) var descriptionShort: String?
    private(set) var email: String?
    private(set) var firstNameClient: String?
    private(set) var firstNameContact: String?
    private(set) var interests: [String]?
    private(set) var nameClient: String?
    private(set) var nameContact: String?
    private(set) var phonenumber: Int?
    private(set) var targetGroup: Int?
    private(set) var zip: String?
    private(set) var projectId: String?
    private(set) var test: String?
    private(set) var hacks: [Hack]?
    
    init(adress: String, city: String, description: String, descriptionShort: String, email: String, firstNameClient: String, firstNameContact: String, nameClient: String, nameContact: String, phonenumber: Int, targetGroup: Int, zip: String, projectId: String) {
        self.adress = adress
        self.city = city
        self.description = description
        self.descriptionShort = descriptionShort
        self.email = email
        self.firstNameClient = firstNameClient
        self.firstNameContact = firstNameContact
        self.nameClient = nameClient
        self.nameContact = nameContact
        self.phonenumber = phonenumber
        self.targetGroup = targetGroup
        self.zip = zip
        self.projectId = projectId
    }
    
    
    func getHacks() {
        var ref = Firestore.firestore().collection("Projects").document(projectId!).collection("Hacks")
        ref.getDocuments { (querySnapshot,err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if querySnapshot!.documents.count >= 1 {
                    for document in querySnapshot!.documents {
                        print("data from hack \(document.data())")
                    }
                }
            }
            
        }
        
    }
    
    
}
