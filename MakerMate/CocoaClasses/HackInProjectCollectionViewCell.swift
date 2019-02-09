//
//  HackInProjectCollectionViewCell.swift
//  MakerMate
//
//  Created by Jens Van Steen on 03/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import ScalingCarousel

class HackInProjectCollectionViewCell: ScalingCarouselCell {
    
    
    @IBOutlet weak private var hackImage: UIImageView!
    @IBOutlet weak private var titleHack: UILabel!
    @IBOutlet weak var currentStepLabel: UILabel!
    
    
    func setUpCell(titleHack: String, currentStepHack: Int) {
        self.titleHack.text = titleHack
        self.currentStepLabel.text = "Hervat stap \(currentStepHack)"
    }
}
