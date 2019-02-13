//
//  MoodCollectionViewCell.swift
//  MakerMate
//
//  Created by Jens Van Steen on 13/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectionImage: UIImageView!
    @IBOutlet weak var moodImage: UIImageView!
    @IBOutlet weak var moodLabel: UILabel!
    var mood: String?
    
    override var isSelected: Bool{
        willSet{
            super.isSelected = newValue
            if newValue
            {
                self.layer.borderWidth = 1.0
                self.layer.borderColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
                self.selectionImage.image = UIImage(named: "mobiCheck")
                self.moodImage.image = UIImage(named: mood!)
            }
            else
            {
                self.layer.borderWidth = 0.0
                self.selectionImage.image = UIImage(named: "mobiUncheck")
                self.moodImage.image = UIImage(named: "\(mood)-unchecked")
            }
        }
    }
    
    func setMood(mood: String) {
        self.mood = mood
        moodLabel.text = mood
        moodImage.image = UIImage(named: "\(mood)-unchecked")
    }
}
