//
//  customTabbar.swift
//  MakerMate
//
//  Created by Jens Van Steen on 11/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class CustomTabbar: UITabBar {
    
    override func awakeFromNib() {
        self.barTintColor = .white
        self.tintColor = .clear
        self.shadowImage = nil
        self.clipsToBounds = true
        
        setTabBarItems()
    }
    
    func setTabBarItems() {
        
        for item in self.items! {
            
            let AttributesNotSelected = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1), NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 10.0)!] as [NSAttributedString.Key : Any]
            let AttributesSelected = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 10.0)!] as [NSAttributedString.Key : Any]
            
            item.setTitleTextAttributes(AttributesSelected, for: .selected)
            item.setTitleTextAttributes(AttributesNotSelected, for: .normal)
            
        }
        
        //Setup Home
        let myTabBarItem1 = (self.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "homeNotSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage(named: "homeSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.title = "Home"
        
        //Setup Projecten
        let myTabBarItem2 = (self.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "projectenNotSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "projectenSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.title = "Projecten"
        
        //Setup Ontdek
        let myTabBarItem3 = (self.items?[2])! as UITabBarItem
        myTabBarItem3.image = UIImage(named: "ontdekNotSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.selectedImage = UIImage(named: "ontdekSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.title = "Ontdek"
    }
    
    
    
}
