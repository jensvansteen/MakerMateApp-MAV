//
//  KennisMakingDetailsView.swift
//  MakerMate
//
//  Created by Jens Van Steen on 04/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class KennisMakingDetailsView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as! MediaKennismakingCollectionViewCell
        
        return cell
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
