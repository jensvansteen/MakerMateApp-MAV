//
//  RequestViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 31/01/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
    }
    
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.1960784314, alpha: 1),
             NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 14)!]
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
     
        self.navigationItem.setHidesBackButton(true, animated:false)
        
        //your custom view for back image with custom size
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 29))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 29))
        
        if let imgBackArrow = UIImage(named: "backButton") {
            imageView.image = imgBackArrow
        }
        view.addSubview(imageView)
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        view.addGestureRecognizer(backTap)
        
        let leftBarButtonItem = UIBarButtonItem(customView: view)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
    }
    
    
    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
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
