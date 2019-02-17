//
//  NotificationDetailViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 13/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class NotificationDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.title = "Fien"
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        
    }
    
    @IBAction func acceptInvite(_ sender: UIButton) {
        LastProject.shared.showProject = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
  
}
