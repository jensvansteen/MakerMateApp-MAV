//
//  NewStepViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 06/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class NewStepViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    

    @IBOutlet weak private var imagePreview: UIImageView!
    @IBOutlet weak private var stepText: UITextView!
    @IBOutlet weak private var itemsNeededCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        itemsNeededCollectionView.dataSource = self
        itemsNeededCollectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addAPhoto(_ sender: UIButton) {
    }
    
    @IBAction func addAItem(_ sender: UIButton) {
        
    }
    
    @IBAction private func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func editDone(_ sender: UIButton) {
        
       self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "materialListCell", for: indexPath) as! ItemInMaterialListEditCollectionViewCell
        
        cell.itemName.text = "Leer"
        
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
