//
//  BackButton.swift
//  MakerMate
//
//  Created by Jens Van Steen on 31/01/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import UIKit

func changeAppereanceBackButton() {
    let barButtonAppearance = UIButton.appearance()
    let backButton = UIImage(named: "backButton")
    let backButtonImage = backButton?.stretchableImage(withLeftCapWidth: 0, topCapHeight: 10)
    barButtonAppearance.setBackgroundImage(backButtonImage, for: .normal)
}
