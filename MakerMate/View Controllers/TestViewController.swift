//
//  TestViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 04/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

//    @IBOutlet weak var textVIew: UILabel!
    
    @IBOutlet weak var testText: UILabel!
    
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func setupHeight(theindex: Int) {
        heightScrollView.constant = CGFloat(theindex * 300)
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

//extension TestViewController: ColoredView {}
