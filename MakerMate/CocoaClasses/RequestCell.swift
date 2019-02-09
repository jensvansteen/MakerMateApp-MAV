//
//  RequestCell.swift
//  MakerMate
//
//  Created by Jens Van Steen on 30/01/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class RequestCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var interests = [String]()
    
    
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
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestCell", for: indexPath) as! IntrestHomeCollectionViewCell
        
        cell.intrestLabel.text = interests[indexPath.row]
        
        return cell
    }
    
    func setUp(request: Request) {
        nameLocation.text = request.city
        nameRequest.text = request.firstNameRequest
        infoRequest.text = request.requestShort
        
        interests = request.interests!
        
        intrestsCollectionView.reloadData()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//        let size = CGSize(width: 200, height: 40)
//        var estimedSizeText: CGRect?
//        if let font = UIFont(name: "Avenir Next", size: 10) {
//            let attributes = [NSAttributedString.Key.font: font]
//            estimedSizeText = NSString(string: interests[indexPath.row]).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
//
//            return CGSize(width: estimedSizeText!.width + 20, height: 23)
//        }
//        return CGSize(width: 40, height: 23)
//    }
    
    
}

