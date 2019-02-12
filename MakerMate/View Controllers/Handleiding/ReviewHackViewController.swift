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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func testDeHack(_ sender: UIButton) {
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "oversightProjectView") as! StepsProjectViewController
        nextViewController.hackInProject = hack
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
