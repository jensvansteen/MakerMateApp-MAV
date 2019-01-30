//
//  ProjectCollectionViewCell.swift
//  MakerMate
//
//  Created by Jens Van Steen on 30/01/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import ScalingCarousel

class ProjectCollectionViewCell: ScalingCarouselCell {
    
    @IBOutlet weak var informationCell: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var projectStep: UILabel!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var hackVoorLabel: UILabel!
    @IBOutlet weak var nextStepLabel: UILabel!
    @IBOutlet weak var addButtonImage: UIImageView!
    @IBOutlet weak var newProjectLabel: UILabel!
    @IBOutlet weak var statANewLabel: UILabel!
    

    func layoutViews(project: Bool, projectName: String, projectStep: String) {
        
        if project {
            self.projectName.text = projectName
            self.projectStep.text = projectStep
            self.cellImage.image = UIImage(named: "ActiveProjectCard")
        } else {
            self.projectName.isHidden = true
            self.projectStep.isHidden = true
            self.nextStepLabel.isHidden = true
            self.hackVoorLabel.isHidden = true
            statANewLabel.isHidden = false
            newProjectLabel.isHidden = false
            addButtonImage.isHidden = false
            self.projectName.text = "newProject"
            self.projectStep.isHidden = true
            self.cellImage.image = UIImage(named: "newProjectCard")
        }

    
    }
    
   


}


