//
//  memberTableViewCell.swift
//  MakerMate
//
//  Created by Jens Van Steen on 12/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class memberTableViewCell: UITableViewCell {

    @IBOutlet weak private var makerImage: UIImageView!
    @IBOutlet weak private var makerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.makerImage.layer.masksToBounds = false
        self.makerImage.layer.borderColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
        self.makerImage.borderWidth = 1.0
        self.makerImage.cornerRadius = self.makerImage.frame.size.width/2
        self.makerImage.clipsToBounds = true
    }


    func setUpCell(makerImage: UIImage, hackerName: String) {
        self.makerImage.image = makerImage
        self.makerNameLabel.text = hackerName
    }

}
