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


class Project {
    
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
//    private(set) var hacks: [Hack]?
    
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
    
    
    class func parseOneData(snapshot: DocumentSnapshot?) -> Project? {
        var project: Project?
        
        guard let document = snapshot else {return project}
            let data = document.data()!
            let id = document.documentID
            let adress = data["adress"] as! String
            let city = data["city"] as! String
            let desscription = data["description"] as! String
            let descriptionShort = data["descriptionShort"] as! String
            let email = data["email"] as! String
            let firstNameClient = data["firstNameClient"] as! String
            let firstNameContact = data["firstNameContact"] as! String
            let nameClient = data["nameClient"] as! String
            let nameContact = data["nameContact"] as! String
            let phonenumber = data["phonenumber"] as! Int
            let targetGroup = data["targetGroup"] as! Int
            let zip = data["zip"] as! String
            let newProject = Project(adress: adress, city: city, description: desscription, descriptionShort: descriptionShort, email: email, firstNameClient: firstNameClient, firstNameContact: firstNameContact, nameClient: nameClient, nameContact: nameContact, phonenumber: phonenumber, targetGroup: targetGroup, zip: zip, projectId: id)
            project = newProject
        
        return project
    }
    
    
//    func getHacks() {
//        var ref = Firestore.firestore().collection("Projects").document(projectId!).collection("Hacks")
//        ref.getDocuments { (querySnapshot,err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                if querySnapshot!.documents.count >= 1 {
//                    for document in querySnapshot!.documents {
//                        print("data from hack \(document.data())")
//                    }
//                }
//            }
//
//        }
//
//    }
    
    
}
