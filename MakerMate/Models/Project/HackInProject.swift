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
    
    
    private(set) var likes: Int
    private(set) var niveau: Int
    private(set) var currentStep: Int
    private(set) var name: String
    private(set) var hackId: String
    private(set) var projectId: String
    private(set) var hackImage: UIImage?
    
    init(likes: Int, niveau: Int, currentStep: Int, name: String, hackId: String, projectId: String) {
        self.likes = likes
        self.niveau = niveau
        self.currentStep = currentStep
        self.name = name
        self.hackId = hackId
        self.projectId = projectId

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
    
    
    
    
    
    
    class func parseData(snapshot: QuerySnapshot?) -> [HackInProject] {
        var hacks = [HackInProject]()
        
        guard let snap = snapshot else {return hacks}
        for document in snap.documents {
            let data = document.data()
            let id = document.documentID
            let projecto = data["projectId"] as! String
            print(projecto)
            print(data)
            let hack = HackInProject(likes: data["likes"] as? Int ?? 0, niveau: data["niveau"] as? Int ?? 0, currentStep: data["currentStep"] as? Int ?? 0, name: data["name"] as? String ?? "Hello", hackId: id, projectId: (data["projectId"] as? String)!)
            hacks.append(hack)
        }
        
      
        
        return hacks
    }
    
}
