//
//  HulpVragenViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 12/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class HulpVragenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let makers = ["Jeroen Schauwers", "Jochen Vanganze", "Elisabeth Coens"]


    @IBOutlet weak private var makersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makersTableView.delegate = self
        makersTableView.dataSource = self

        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.title = "Hulp zoeken"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return makers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "makerCell", for: indexPath) as! memberTableViewCell
        cell.setUpCell(makerImage: UIImage(named: makers[indexPath.row])!, hackerName: makers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row ==  0 {
            performSegue(withIdentifier: "detailViewMaker", sender: indexPath)
        }
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
