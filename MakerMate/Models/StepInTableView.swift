//
//  stepInTableView.swift
//  MakerMate
//
//  Created by Jens Van Steen on 06/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import UIKit

class StepInTableView {
    var title: String
    var description: String
    var image: UIImage
    
    
    init(titled: String, description: String, imageName: String)
    {
        self.title = titled
        self.description = description
        if let img = UIImage(named: imageName) {
            image = img
        } else {
            image = UIImage(named: "cellPreview")!
        }
    }
}
