//
//  StepOrderViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 06/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit

class StepOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    let steps = [1,2,3,4,5]
    
    @IBOutlet weak var stepsTableVIew: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        stepsTableVIew.dataSource = self
        stepsTableVIew.delegate = self
//        stepsTableVIew.dragDelegate = self
//        stepsTableVIew.dropDelegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepOrderCell", for: indexPath) as! stepCellTableViewCell
        
        cell.setUpCell(index: 1, description: "Span the leather on a wooden plate; one can use tape ", stepImage: UIImage(named: "cellPreview")!)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        return stepsTableVIew.dragItems(for: indexPath)
//    }
    
//    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//        <#code#>
//    }
//
//
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let stepToMove = steps[]
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func dismissEditing(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
