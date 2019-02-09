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

class Hack {
    
    
    private(set) var likes: Int
    private(set) var niveau: Int
//    private(set) var readyForTesting: Bool
    private(set) var currentStep: Int
    private(set) var name: String
    var productId: String
    
    init(likes: Int, niveau: Int, currentStep: Int, name: String, productId: String) {
        self.likes = likes
        self.niveau = niveau
//        self.readyForTesting = readyForTesting
        self.currentStep = currentStep
        self.name = name
        self.productId = productId
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Hack] {
        var hacks = [Hack]()
        
        guard let snap = snapshot else {return hacks}
        for document in snap.documents {
            let data = document.data()
            let id = document.documentID
            print(data)
            let hack = Hack(likes: data["likes"] as? Int ?? 0, niveau: data["niveau"] as? Int ?? 0, currentStep: data["currentStep"] as? Int ?? 0, name: data["name"] as? String ?? "Hello", productId: id as! String)
            hacks.append(hack)
        }
        
        return hacks
    }
    
}
