//
//  RequestViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 31/01/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let intrest = ["Dieren", "Winkelen", "Humor", "Iets gaan drinken"]
    @IBOutlet weak var intrestsCollectionView: UICollectionView!
    @IBOutlet weak var widthCollectionView: NSLayoutConstraint!
    @IBOutlet weak var targetGroupName: UILabel!
    @IBOutlet weak var targetGroupNameView: UIView!
    @IBOutlet weak var widthLabelTagTargetGroup: NSLayoutConstraint!
    @IBOutlet weak var requestShort: UILabel!
    
    var width: CGFloat = 0 {
        didSet {
            widthCollectionView.constant = width
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.intrestsCollectionView.delegate = self
        self.intrestsCollectionView.dataSource = self

        let widthContent = intrestsCollectionView.contentSize.width
        print("this widht of the content is \(widthContent)")
        
        setTextShort()
        
        setupNavigationBar()
    }
    
  
    func setTextShort() {
        let currentText = requestShort.text
        let newText = "\"\(currentText!)\""
        requestShort.text = newText
    }
    
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.1960784314, alpha: 1),
             NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 14)!]
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
     
        self.navigationItem.setHidesBackButton(true, animated:false)
        
        //your custom view for back image with custom size
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 29))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 29))
        
        if let imgBackArrow = UIImage(named: "backButton") {
            imageView.image = imgBackArrow
        }
        view.addSubview(imageView)
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        view.addGestureRecognizer(backTap)
        
        let leftBarButtonItem = UIBarButtonItem(customView: view)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
    }
    
    
    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return intrest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestCell", for: indexPath) as! IntrestHomeCollectionViewCell
        cell.intrestLabel.text = intrest[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 200, height: 23)
        var estimedSizeText: CGRect?
        if let font = UIFont(name: "Avenir Next", size: 10) {
            let attributes = [NSAttributedString.Key.font: font]
            estimedSizeText = NSString(string: intrest[indexPath.row]).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            width += (estimedSizeText!.width + 20 + 10)
            return CGSize(width: estimedSizeText!.width + 20, height: 23)
        }
        return CGSize(width: 40, height: 23)
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
