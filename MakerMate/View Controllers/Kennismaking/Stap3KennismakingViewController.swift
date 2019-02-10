//
//  Stap3KennismakingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 10/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap3KennismakingViewController: UIViewController {
    
    
    @IBOutlet weak var aanrakingSlider: UISlider!
    @IBOutlet weak var pijnOngemakSlider: UISlider!
    @IBOutlet weak var fysiekeInspanningSlider: UISlider!
    @IBOutlet weak var motoriekSlider: UISlider!
    @IBOutlet weak var evenwichtSlider: UISlider!
    @IBOutlet weak var waarnemenSlider: UISlider!
    @IBOutlet weak var begrijpVertel: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupSlider()
    }
    
    
    private func setupSlider() {
        //aanrakingSLider
        aanrakingSlider.setThumbImage(UIImage(named: "aanrakingNotSelected"), for: .normal)
        aanrakingSlider.setThumbImage(UIImage(named: "aanrakingNotSelected"), for: .focused)
        aanrakingSlider.setThumbImage(UIImage(named: "aanrakingNotSelected"), for: .highlighted)
        aanrakingSlider.setValue(2.0, animated: false)
        //pijnOngemakSlider
        pijnOngemakSlider.setThumbImage(UIImage(named: "pijnongemakNotSelected"), for: .normal)
        pijnOngemakSlider.setThumbImage(UIImage(named: "pijnongemakNotSelected"), for: .focused)
        pijnOngemakSlider.setThumbImage(UIImage(named: "pijnongemakNotSelected"), for: .highlighted)
        pijnOngemakSlider.setValue(2.0, animated: false)
        //fysiekeInspanningSlider
        fysiekeInspanningSlider.setThumbImage(UIImage(named: "fysiekeNotSelected"), for: .normal)
        fysiekeInspanningSlider.setThumbImage(UIImage(named: "fysiekeNotSelected"), for: .focused)
        fysiekeInspanningSlider.setThumbImage(UIImage(named: "fysiekeNotSelected"), for: .highlighted)
        fysiekeInspanningSlider.setValue(2.0, animated: false)
        //motoriekSlider
        motoriekSlider.setThumbImage(UIImage(named: "motoriekNotSelected"), for: .normal)
        motoriekSlider.setThumbImage(UIImage(named: "motoriekNotSelected"), for: .focused)
        motoriekSlider.setThumbImage(UIImage(named: "motoriekNotSelected"), for: .highlighted)
        motoriekSlider.setValue(2.0, animated: false)
        //evenwichtSlider
        evenwichtSlider.setThumbImage(UIImage(named: "evenwichtNotSelected"), for: .normal)
        evenwichtSlider.setThumbImage(UIImage(named: "evenwichtNotSelected"), for: .focused)
        evenwichtSlider.setThumbImage(UIImage(named: "evenwichtNotSelected"), for: .highlighted)
        evenwichtSlider.setValue(2.0, animated: false)
        //waarnemenSlider
        waarnemenSlider.setThumbImage(UIImage(named: "warmteKoudeNotSelected"), for: .normal)
        waarnemenSlider.setThumbImage(UIImage(named: "warmteKoudeNotSelected"), for: .focused)
        waarnemenSlider.setThumbImage(UIImage(named: "warmteKoudeNotSelected"), for: .highlighted)
        waarnemenSlider.setValue(2.0, animated: false)
        //begrijpVertel
        begrijpVertel.setThumbImage(UIImage(named: "begrijpNotSelected"), for: .normal)
        begrijpVertel.setThumbImage(UIImage(named: "begrijpNotSelected"), for: .focused)
        begrijpVertel.setThumbImage(UIImage(named: "begrijpNotSelected"), for: .highlighted)
        begrijpVertel.setValue(2.0, animated: false)
    }
    
    @IBAction func updateSlider(_ sender: UISlider) {
        let fixed = roundf(sender.value)
        sender.setValue(fixed, animated: true)
        
        if sender.tag == 0 {
            if aanrakingSlider.value == 1.0 || aanrakingSlider.value == 3.0 {
                aanrakingSlider.setThumbImage(UIImage(named: "aanrakingSelected"), for: .normal)
            } else {
                aanrakingSlider.setThumbImage(UIImage(named: "aanrakingNotSelected"), for: .normal)
            }
        } else if sender.tag == 1 {
            if pijnOngemakSlider.value == 1.0 || pijnOngemakSlider.value == 3.0 {
                pijnOngemakSlider.setThumbImage(UIImage(named: "pijnongemakSelected"), for: .normal)
            } else {
                pijnOngemakSlider.setThumbImage(UIImage(named: "pijnongemakNotSelected"), for: .normal)
            }
        } else if sender.tag == 2 {
            if fysiekeInspanningSlider.value == 1.0 || fysiekeInspanningSlider.value == 3.0 {
                fysiekeInspanningSlider.setThumbImage(UIImage(named: "fysiekeSelected"), for: .normal)
            } else {
                fysiekeInspanningSlider.setThumbImage(UIImage(named: "fysiekeNotSelected"), for: .normal)
            }
        } else if sender.tag == 3 {
            if motoriekSlider.value == 1.0 || motoriekSlider.value == 3.0 {
                motoriekSlider.setThumbImage(UIImage(named: "motoriekSelected"), for: .normal)
            } else {
                motoriekSlider.setThumbImage(UIImage(named: "motoriekNotSelected"), for: .normal)
            }
        } else if sender.tag == 4 {
            if evenwichtSlider.value == 1.0 || evenwichtSlider.value == 3.0 {
                evenwichtSlider.setThumbImage(UIImage(named: "evenwichtSelected"), for: .normal)
            } else {
                evenwichtSlider.setThumbImage(UIImage(named: "evenwichtNotSelected"), for: .normal)
            }
        } else if sender.tag == 5 {
            if waarnemenSlider.value == 1.0 || waarnemenSlider.value == 3.0 {
                waarnemenSlider.setThumbImage(UIImage(named: "warmteKoudeSelected"), for: .normal)
            } else {
                waarnemenSlider.setThumbImage(UIImage(named: "warmteKoudeNotSelected"), for: .normal)
            }
        } else if sender.tag == 6 {
            if begrijpVertel.value == 1.0 || begrijpVertel.value == 3.0 {
                begrijpVertel.setThumbImage(UIImage(named: "begrijpSelected"), for: .normal)
            } else {
                begrijpVertel.setThumbImage(UIImage(named: "begrijpNotSelected"), for: .normal)
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
