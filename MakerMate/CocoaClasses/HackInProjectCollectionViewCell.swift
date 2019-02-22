//
//  HackInProjectCollectionViewCell.swift
//  MakerMate
//
//  Created by Jens Van Steen on 03/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import ScalingCarousel
import Firebase

class HackInProjectCollectionViewCell: ScalingCarouselCell {
    
    let referenceToStorage = Storage.storage()
    
    @IBOutlet weak private var hackImage: UIImageView!
    @IBOutlet weak private var titleHack: UILabel!
    @IBOutlet weak var currentStepLabel: UILabel!
    

    
    
    override func awakeFromNib() {
        
    }
    
    
    func setUpCell(titleHack: String, currentStepHack: Int, hackId: String) {
        self.titleHack.text = titleHack
        self.currentStepLabel.text = "Hervat stap \(currentStepHack)"
        self.hackImage.isHidden = false
        self.titleHack.isHidden = false
        currentStepLabel.isHidden = false
        
        let gsReference = referenceToStorage.reference(forURL: "gs://makermate-a22cc.appspot.com/hacks/\(hackId)/imageHack.jpg")

        gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("the error is \(error)")
            } else {
                let image = UIImage(data: data!)
                self.hackImage.image = image

            }
        }
        
     


    }
    
    
    func layoutbasic() {
        hackImage.isHidden = true
        self.titleHack.isHidden = true
        currentStepLabel.isHidden = true
    }
}
