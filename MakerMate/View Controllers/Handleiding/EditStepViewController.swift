//
//  EditStepViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 06/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage


//protocol ChildViewControllerDelegate {
//    func childViewControllerResponse(someText: String)
//}


class EditStepViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //    var delegate: ChildViewControllerDelegate
    
    @IBOutlet weak var dimmerView: UIView!
    @IBOutlet weak var materialsCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var imageSmall: UIImageView!
    @IBOutlet weak var heigthCollectionView: NSLayoutConstraint!
    
    var storageRef: StorageReference!
    
    var picker = UIImagePickerController()
    
    var indexOfStep: Int?
    
    var parentviewcontroller: GuideStepViewController!
    
    var items = ["Leer", "Schaar"]
    
    
    //    var holdingNavigationController: AlwaysPoppableNavigationController!
    //    var activeStepView: GuideStepViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageRef = Storage.storage().reference()
        
        // Do any additional setup after loading the view.
        
        materialsCollectionView.delegate = self
        materialsCollectionView.dataSource = self
        
        self.descriptionTextField.delegate = self
        
        
        
        self.view.backgroundColor = .clear
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.isNavigationBarHidden = true
        
        let guideHoldingController = presentingViewController as? GuideHoldingViewController
        indexOfStep = guideHoldingController?.scrollViewController.currentIndex
        parentviewcontroller = guideHoldingController?.scrollViewController.viewControllers[(guideHoldingController?.scrollViewController.currentIndex)!] as! GuideStepViewController
        
        updateCollectionViewHeight()
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let mediaType: String = info[UIImagePickerController.InfoKey.mediaType] as? String else {
            return
        }
        if mediaType == "public.image" {
            if let originalImage = info[.originalImage] as? UIImage {
                let imageData = originalImage.jpegData(compressionQuality: 0.8)
//                LastProject.shared.uploadImageToFirebaseStorage(data: imageData)
                uploadImageToFirebaseStorage(data: imageData!)
                let selectedPhoto = info[.originalImage] as! UIImage
                imageSmall.image = selectedPhoto
                parentviewcontroller.imageStep.image = selectedPhoto
            }
        } else if mediaType == "public.movie" {
            if let movieURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL {
                uploadMovieToFirebaseStorage(data: movieURL)
            }
        }
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func voegFotoToeHandler(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)
            //            let mediaTypes = [kuTTypeImage as String]
            picker.mediaTypes = mediaTypes!
            picker.sourceType = .photoLibrary
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        }
    }
    
    
    func uploadImageToFirebaseStorage(data: Data) {
        let storageRef = Storage.storage().reference()
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        let imageRef = storageRef.child("hackSteps")
        let imageRefofRef = imageRef.child("m9jD7xXwE1Yza3xcKBCM")
        let fileName = "stap\(indexOfStep!+1)"
        let spaceRef = imageRefofRef.child(fileName)
        let path = spaceRef.fullPath
        let uploadTask = spaceRef.putData(data, metadata: uploadMetadata) { (metadata, error) in
            if let error = error {
                print("error uploading \(error)")
                return
            }

        }

        }
    
    
    func uploadMovieToFirebaseStorage(data: NSURL) {
        // make this work
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        modalPresentationStyle = .overFullScreen //dont dismiss the presenting view controller when presented
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "materialInListCell", for: indexPath) as! ItemInMaterialListEditCollectionViewCell
        
        cell.itemName.text = items[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        self.materialsCollectionView.reloadData()
        updateCollectionViewHeight()
    }
    
    func updateCollectionViewHeight() {
        var collectionViewHeight: Int = 0
        for item in items {
            collectionViewHeight += 50
        }
        
        heigthCollectionView.constant = CGFloat(collectionViewHeight)
    }
    
    @IBAction private func changePhoto(_ sender: UIButton) {
    }
    
    @IBAction private func editDone(_ sender: UIButton) {
        
        parentviewcontroller.logChange(text: descriptionTextField.text)
        
        dismiss(animated: true, completion: nil)
        
        
        //        activeStepView.logChange(text: "Test")
    }
    
    @IBAction private func editSteps(_ sender: UIButton) {
        performSegue(withIdentifier: "editStepOrder", sender: sender)
    }
    
    @IBAction private func addAStep(_ sender: UIButton) {
    }
    
    
    @IBAction private func addItem(_ sender: UIButton) {
        let alert = UIAlertController(title: "Voeg een item toe", message: "", preferredStyle: .alert)
        
        
        let ok = UIAlertAction(title: "Add",
                               style: UIAlertAction.Style.default) { (action: UIAlertAction) in
                                if let alertTextField = alert.textFields?.first, alertTextField.text != nil {
                                    self.items.append(alertTextField.text!)
                                    self.materialsCollectionView.reloadData()
                                    self.updateCollectionViewHeight()
                                }
        }
        
        let cancel = UIAlertAction(title: "Cancel",
                                   style: UIAlertAction.Style.cancel,
                                   handler: nil)
        
        alert.addTextField { (textField: UITextField) in
            
            textField.placeholder = "Voer hier je stap in"
            
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
