//
//  mobiCollectionViewCell.swift
//  MakerMate
//
//  Created by Jens Van Steen on 11/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class mobiCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mobiClassImage: UIImageView!
    @IBOutlet weak var mobiClassText: UILabel!
    @IBOutlet weak var selectionImage: UIImageView!
    
    
    override var isSelected: Bool{
        willSet{
            super.isSelected = newValue
            if newValue
            {
                self.layer.borderWidth = 1.0
                self.layer.borderColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
                self.selectionImage.image = UIImage(named: "mobiCheck")
            }
            else
            {
                self.layer.borderWidth = 0.0
                self.selectionImage.image = UIImage(named: "mobiUncheck")
            }
        }
    }
    
}
