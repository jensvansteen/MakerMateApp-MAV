//
//  HackDetailKennismakingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 11/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import Firebase

class HackDetailKennismakingViewController: UIViewController {
    
    let level = [1: "MAKKELIJK", 2: "GEMIDDELD", 3: "MOEILIJK"]
    
    @IBOutlet weak private var hackImage: UIImageView!
    @IBOutlet weak private var hackNameLabel: UILabel!
    @IBOutlet weak var levelHackLabel: UILabel!
    @IBOutlet weak var hackLikesLabel: UILabel!
    @IBOutlet weak var imageOfHack: UIImageView!
    
    var hack: Hack?
    
    let referenceToStorage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        
        print(hack)
        
        if let hack = hack {
            hackNameLabel.text = hack.name
            levelHackLabel.text = level[hack.niveau]
            hackLikesLabel.text = String(hack.likes)
            
            if let hackimg = hack.hackImage {
                imageOfHack.image = hackimg
            } else {
                let gsReference = referenceToStorage.reference(forURL: "gs://makermate-a22cc.appspot.com/hacks/\(hack.hackId)/imageHack.jpg")
                
                gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print("the error is \(error)")
                    } else {
                        let image = UIImage(data: data!)
                        self.imageOfHack.image = image
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func addToProject(_ sender: UIButton) {
        performSegue(withIdentifier: "goToOversight", sender: sender)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOversight" {
            let toVC = segue.destination as! addedHacksViewController
            if let hack = hack {
                toVC.hack = hack
            }
        }
    }
    
}
