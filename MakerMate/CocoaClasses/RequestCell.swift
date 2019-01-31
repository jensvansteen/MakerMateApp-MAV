//
//  RequestCell.swift
//  MakerMate
//
//  Created by Jens Van Steen on 30/01/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class RequestCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionViewData = [""]
    
    
    @IBOutlet weak var nameRequest: UILabel!
    @IBOutlet weak var infoRequest: UILabel!
    @IBOutlet weak var nameLocation: UILabel!
    @IBOutlet weak var intrestsCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        intrestsCollectionView.dataSource = self
        intrestsCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestCell", for: indexPath) as! IntrestHomeCollectionViewCell
        
        cell.intrestLabel.text = collectionViewData[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let size = CGSize(width: 200, height: 40)
        var estimedSizeText: CGRect?
        if let font = UIFont(name: "Avenir Next", size: 10) {
            let attributes = [NSAttributedString.Key.font: font]
            estimedSizeText = NSString(string: collectionViewData[indexPath.row]).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            return CGSize(width: estimedSizeText!.width + 20, height: 23)
        }
        return CGSize(width: 40, height: 23)
    }
    
    
}

