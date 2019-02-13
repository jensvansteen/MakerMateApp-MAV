//
//  NotificationsViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 13/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    @IBOutlet weak private var imageMelding: UIImageView!
    @IBOutlet weak private var tableVieww: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.title = "Meldingen"
        
        self.imageMelding.layer.masksToBounds = false
        self.imageMelding.layer.borderColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
        self.imageMelding.borderWidth = 1.0
        self.imageMelding.cornerRadius = self.imageMelding.frame.size.width/2
        self.imageMelding.clipsToBounds = true
        
        
        let tapView = UITapGestureRecognizer(target: self, action: #selector(goToDetail))
        tableVieww.addGestureRecognizer(tapView)
        tableVieww.isUserInteractionEnabled = true
    }
    
    
    @objc private func goToDetail() {
        performSegue(withIdentifier: "inviteDetail", sender: nil)
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
