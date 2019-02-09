//
//  Request.swift
//  MakerMate
//
//  Created by Jens Van Steen on 08/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class Request {
    
    var db: Firestore!
    
    private(set) var adress: String?
    private(set) var age: Int?
    private(set) var city: String?
    private(set) var email: String?
    private(set) var firstNameRequest: String?
    private(set) var firstNameContact: String?
    private(set) var interests: [String]?
    private(set) var nameContact: String?
    private(set) var nameRequest: String?
    private(set) var requestLong: String?
    private(set) var requestShort: String?
    private(set) var telephone: Int?
    private(set) var zip: String?
    private(set) var idRequest: String
    
    

    
    private init(adress: String, age: Int, city: String, email: String, firstNameRequest: String, firstNameContact: String, interests: [String], nameContact: String, nameRequest: String, requestLong: String, requestShort: String, telephone: Int, zip: String, idRequest: String) {
        self.adress = adress
        self.age = age
        self.city = city
        self.email = email
        self.firstNameRequest = firstNameRequest
        self.firstNameContact = firstNameContact
        self.interests = interests
        self.nameContact = nameContact
        self.nameRequest = nameRequest
        self.requestLong = requestLong
        self.requestShort = requestShort
        self.telephone = telephone
        self.zip = zip
        self.idRequest = idRequest
    }
    
    
    func addToProjectsFromRequest() {
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        ref = db.collection("Projects").addDocument(data: [
            "adress": "\(self.adress!)",
            "city": "\(self.city!)",
            "description": "\(self.requestLong!)",
            "descriptionShort": "\(self.requestShort!)",
            "email": "\(self.email!)",
            "firstNameClient": "\(self.firstNameRequest!)",
            "firstNameContact": "\(self.firstNameContact!)",
            "nameClient": "\(self.nameRequest!)",
            "nameContact": "\(self.nameContact!)",
            "phonenumber": self.telephone!,
            "targetGroup": self.age!,
            "zip": self.zip!
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                let documentUpdate = self.db.collection("Projects").document(ref!.documentID)

                LastProject.shared.idLastProject = ref!.documentID
                // Set the "capital" field of the city 'DC'
                documentUpdate.updateData([
                    "interests": self.interests
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        }
        
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Request] {
        var requests = [Request]()
        
        guard let snap = snapshot else {return requests}
        for document in snap.documents {
            let data = document.data()
            let id = document.documentID
            print(data)
            let adress = data["adress"] as! String
            let age = data["age"] as! Int
            let city = data["city"] as! String
            let email = data["email"] as! String
            let firstNameRequest = data["firstNameRequest"] as! String
            let firstNameContact = data["firstNameContact"] as! String
            let interestsToParse = data["interests"] as! [String]
            let nameContact = data["nameContact"] as! String
            let nameRequest = data["nameRequest"] as! String
            let requestLong = data["requestLong"] as! String
            let requestShort = data["requestShort"] as! String
            let telephone = data["telephone"] as! Int
            let zip = data["zip"] as! String
            let request = Request(adress: adress, age: age, city: city, email: email, firstNameRequest: firstNameRequest, firstNameContact: firstNameContact, interests: interestsToParse, nameContact: nameContact, nameRequest: nameRequest, requestLong: requestLong, requestShort: requestShort, telephone: telephone, zip: zip, idRequest: id)
            requests.append(request)
        }
        
        return requests
    }
    
}
