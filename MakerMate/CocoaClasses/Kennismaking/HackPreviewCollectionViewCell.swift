//
//  HackPreviewCollectionViewCell.swift
//  MakerMate
//
//  Created by Jens Van Steen on 11/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import Firebase

class HackPreviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var hackImage: UIImageView!
    @IBOutlet weak private var hackNameLabel: UILabel!
    @IBOutlet weak private var hackDescriptionLabel: UILabel!
    private var hack: Hack!
    
    
    func setUpCell(hack: Hack) {
        
        hackNameLabel.text = hack.name
        hackDescriptionLabel.text = "Whoops vergeten een description in de database te zetten"
        
        let referenceToStorage = Storage.storage()
        
        if let hackImage = hack.hackImage {
            self.hackImage.image = hackImage
        } else {
            let gsReference = referenceToStorage.reference(forURL: "gs://makermate-a22cc.appspot.com/hacks/\(hack.hackId)/imageHack.jpg")
            
            gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("the error is \(error)")
                } else {
                    let image = UIImage(data: data!)
                    self.hackImage.image = image
                }
            }
        }
        
    }
}
