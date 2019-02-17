//
//  MaterialCollectionViewCell.swift
//  MakerMate
//
//  Created by Jens Van Steen on 17/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class MaterialCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak private var materialNaamLabel: UILabel!
    @IBOutlet weak private var aantalLabel: UILabel!
    
    
    func setUp(materialName: String, number: Int) {
        self.materialNaamLabel.text = materialName
        self.aantalLabel.text = "\(String(number))x"
    }
    
}
