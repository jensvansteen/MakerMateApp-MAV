//
//  ReviewHackViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 05/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class ReviewHackViewController: UIViewController {

    @IBOutlet weak var reviewSlider: UISlider!
    
    
    var hack: HackInProject?
    
        var guideHoldingController: GuideHoldingViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    @IBAction func testDeHack(_ sender: UIButton) {
        
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "testHolder") as! AlwaysPoppableNavigationController
//        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "testHolder") as! StepsProjectViewController
        let newVC = nextViewController.viewControllers.first as! StepsProjectViewController
        newVC.hackInProject = hack
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        let fixed = roundf(sender.value)
        sender.setValue(fixed, animated: true)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
