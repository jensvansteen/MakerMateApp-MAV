//
//  lastProject.swift
//  MakerMate
//
//  Created by Jens Van Steen on 09/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LastProject {
    
    static var shared = LastProject()
    
    var idLastProject: String? = ""
    var showProject = false
    
    func uploadImageToFirebaseStorage(data: URL) {
        let storageRef = Storage.storage().reference()
        let uploadMetadata = StorageMetadata()
//        uploadMetadata.contentType = "image/jpeg"
//        let imageRef = storageRef.child("hackSteps")
//        let fileName = "stap\(400)"
//        let spaceRef = imageRef.child(fileName)
        let path = storageRef.fullPath
                let uploadTask = storageRef.putFile(from: data, metadata: nil) { (metadata, error) in
                    if let error = error {
                        print("error uploading \(error)")
                        return
                    }
        
                }
        
    }
    
}
