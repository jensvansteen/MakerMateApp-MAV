//
//  Stap2TestHackViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 12/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap2TestHackViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
       let mooodData = [1: "Spannend", 2: "Controle", 3: "Verveling", 4: "Comfortabel", 5: "Ontspanning", 6: "Apathie", 7: "Bezorgdheid", 8: "Angst"]

    @IBOutlet weak var emotieCollectionVIew: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emotieCollectionVIew.delegate = self
        emotieCollectionVIew.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mooodData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moodCell", for: indexPath) as! MoodCollectionViewCell
        cell.setMood(mood: mooodData[indexPath.row + 1]!)
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

}
