//
//  User.swift
//  MakerMate
//
//  Created by Jens Van Steen on 07/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import Firebase

class User {
    private(set) var email: String
    private(set) var firstName: String
    private(set) var lastName: String
    private(set) var imagePath: String
    private(set) var mate: Bool
    private(set) var userID: String
    private(set) var id: String
    private(set) var projects: [String]?
    
    init(email: String, firstName: String, lastName: String, imagePath: String, mate: Bool, UserID: String, id: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.imagePath = imagePath
        self.mate = mate
        self.userID = UserID
        self.id = id
    }
    
    
    class func parseOneData(snapshot: DocumentSnapshot?) -> User? {
        var user: User?
        
        guard let document = snapshot else {return user}
        let data = document.data()!
        let id = document.documentID
        let email = data["email"] as! String
        let firstName = data["firstName"] as! String
        let imagePath = data["imagePath"] as! String
        let lastName = data["lastName"] as! String
        let mate = data["mate"] as! Bool
        let userID = data["userID"] as! String
        let deUser = User(email: email, firstName: firstName, lastName: lastName, imagePath: imagePath, mate: mate, UserID: userID, id: id)
        if let projects = data["projects"] as! [String]? {
            deUser.projects = projects
        }
        user  = deUser
        
        return user
    }
    
    
    class func parseData(snapshot: QuerySnapshot?) -> User? {
        var user: User?
        
        guard let snap = snapshot else {return user!}
        for document in snap.documents {
            let data = document.data()
            let id = document.documentID
            let email = data["email"] as! String
            let firstName = data["firstName"] as! String
            let imagePath = data["imagePath"] as! String
            let lastName = data["lastName"] as! String
            let mate = data["mate"] as! Bool
            let userID = data["userID"] as! String
            let deUser = User(email: email, firstName: firstName, lastName: lastName, imagePath: imagePath, mate: mate, UserID: userID, id: id)
            if let projects = data["projects"] as! [String]? {
                deUser.projects = projects
            }
            user  = deUser
        }
        
        return user
    }
    
    
    
}




