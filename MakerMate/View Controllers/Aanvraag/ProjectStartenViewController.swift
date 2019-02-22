//
//  ProjectStartenViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 01/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class ProjectStartenViewController: UIViewController {
    @IBOutlet weak var stepView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        stepView.addGestureRecognizer(tap)
        stepView.isUserInteractionEnabled = true

    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(navigationController!.viewControllers.count > 1){
            return true
        }
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        performSegue(withIdentifier: "showRequest", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        initialScrollDone = false
        
        if segue.identifier == "showRequest" {
            
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
//            let activeGuide = ActiveGuide(context: context)
//            activeGuide.guideId = guides[cellInCenter!].id
            
        }
    }

}
