//
//  addedHacksViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 11/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class addedHacksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var hack: Hack?
    
    @IBOutlet weak private var closeView: UIImageView!
    @IBOutlet weak private var addedHacksCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addedHacksCollectionView.dataSource = self
        addedHacksCollectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hackSelectedCell", for: indexPath) as! hackOversightCollectionViewCell
        if let hack = hack {
             let hackToAdd = hack as Hack
             cell.setUpCell(hack: hackToAdd)
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addToProject(_ sender: UIButton) {
        kennismakingSteps.sharedInstance.pushToFirebase()
        hack!.addToProject(projectId: LastProject.shared.idLastProject!)
        let tabBarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
        tabBarController.selectedIndex = 1
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
