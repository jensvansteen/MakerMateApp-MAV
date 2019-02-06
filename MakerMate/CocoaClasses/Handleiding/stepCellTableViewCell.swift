//
//  stepCellTableViewCell.swift
//  MakerMate
//
//  Created by Jens Van Steen on 06/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class stepCellTableViewCell: UITableViewCell {

    @IBOutlet weak var stepImage: UIImageView!
    @IBOutlet weak var stepTitle: UILabel!
    @IBOutlet weak var stepDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setUpCell(index: Int, description: String, stepImage: UIImage) {
        self.stepTitle.text = "STAP \(index)"
        self.stepDescription.text = description
        self.stepImage.image = stepImage
    }

}
