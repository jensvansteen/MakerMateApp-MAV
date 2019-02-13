//
//  RequestViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 31/01/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    
    let ageClass = [1: "kinderen (-12 jaar)", 2: "jongeren (-26 jaar)", 3: "volwassenen (26+ jaar)", 4: "senioren (65+ jaar)"]

    private var interests = [String]()
    var request: Request?
    @IBOutlet weak private var intrestsCollectionView: UICollectionView!
    @IBOutlet weak private var widthCollectionView: NSLayoutConstraint!
    @IBOutlet weak private var targetGroupName: UILabel!
    @IBOutlet weak private var targetGroupNameView: UIView!
    @IBOutlet weak private var widthLabelTagTargetGroup: NSLayoutConstraint!
    @IBOutlet weak private var requestShort: UILabel!
    @IBOutlet weak var requestLong: UILabel!
    @IBOutlet weak var locationlabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
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
        
        setData()
        
        setupNavigationBar()
    }
    
  
    private func setData() {
        guard let requestToDisplay = request else {return}
        requestShort.text = "\"\(requestToDisplay.requestShort!)\""
        targetGroupName.text = ageClass[requestToDisplay.age!]!
        locationlabel.text = requestToDisplay.city!
        nameLabel.text = requestToDisplay.firstNameRequest!
        interests = requestToDisplay.interests!
        
        intrestsCollectionView.reloadData()
    }
    
    private func setupNavigationBar() {
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
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
    }
    
    
    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func backToHome(_ sender: UIButton) {
        
        LastProject.shared.showProject = true
        
        request!.addToProjectsFromRequest()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func displayActionSheet(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        optionMenu.addAction(UIAlertAction(title: "Aanvraag later herhalen", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        
        optionMenu.addAction(UIAlertAction(title: "Aanvraag niet meer laten zien", style: UIAlertAction.Style.destructive, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        
        
        optionMenu.addAction(UIAlertAction(title: "Annuleer", style: UIAlertAction.Style.cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        
    
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestCell", for: indexPath) as! IntrestHomeCollectionViewCell
        cell.intrestLabel.text = interests[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 200, height: 23)
        var estimedSizeText: CGRect?
        if let font = UIFont(name: "Avenir Next", size: 10) {
            let attributes = [NSAttributedString.Key.font: font]
            estimedSizeText = NSString(string: interests[indexPath.row]).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
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
