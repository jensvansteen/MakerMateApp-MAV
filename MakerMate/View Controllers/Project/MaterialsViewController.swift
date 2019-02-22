//
//  MaterialsViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 17/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class MaterialsViewControllerProject: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let items = [["name": "Lijm", "quantity": 1], ["name": "Schuurpapier", "quantity": 1], ["name": "Stuk Hout", "quantity": 6], ["name": "Rem", "quantity": 1], ["name": "Touw met stretch", "quantity": 1], ["name": "Wax", "quantity": 1], ["name": "Verf", "quantity": 1], ["name": "Schuim", "quantity": 1], ["name": "Oogbout", "quantity": 2]]
 
     let buttonBar = UIView()
    
    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    @IBOutlet weak private var segmentContainer: UIView!
    @IBOutlet weak private var materialsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        materialsCollectionView.delegate = self
        materialsCollectionView.dataSource = self
        
        setupNavigationBar()
        setupSegmentControl()
    }
    
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationItem.title = "Materialen"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.1960784314, alpha: 1),
             NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 16)!]
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
       
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = .white
    }
    
    
    private func setupSegmentControl() {
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.1960784314, alpha: 1),
                                                  NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14)!], for: .normal)
        
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1),
                                                  NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 14)!], for: .selected)
        
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
      
        // This needs to be false since we are using auto layout constraints
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
        
        segmentContainer.addSubview(buttonBar)
        
        
        buttonBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)).isActive = true
        
    }
    
   
    
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControl.frame.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "materialcell", for: indexPath) as! MaterialCollectionViewCell
        
        cell.setUp(materialName: items[indexPath.row]["name"] as! String , number: items[indexPath.row]["quantity"] as! Int)
        
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
