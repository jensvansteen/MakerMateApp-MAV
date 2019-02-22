//
//  Stap7KennismakingViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 11/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class Stap7KennismakingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak private var cameraView: UIImageView!
    @IBOutlet weak private var closeView: UIImageView!
    @IBOutlet weak private var photosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        let tapCamera = UITapGestureRecognizer(target: self, action: #selector(openCamera))
        cameraView.addGestureRecognizer(tapCamera)
        cameraView.isUserInteractionEnabled = true
        
        
        //Setup closeButton
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        closeView.addGestureRecognizer(tapDismiss)
        closeView.isUserInteractionEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCellKennismaking", for: indexPath)
        return cell
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @objc private func openCamera() {
        
    }
    
    @objc private func handleDismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToNextStep(_ sender: UIButton) {
        performSegue(withIdentifier: "AanvraagStap8", sender: sender)
    }
    
}
