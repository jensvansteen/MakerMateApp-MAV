//
//  PersonallInfoViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 12/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PersonallInfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var db: Firestore!
    
    @IBOutlet weak private var firstNameTextField: UITextField!
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var addPhotoView: UIView!
    @IBOutlet weak private var profilePicture: UIImageView!
    @IBOutlet weak private var changePhotoButton: UIButton!
    
    private var imagePicker = UIImagePickerController()
    
    var password: String?
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            // 2
            if user != nil {
                self.performSegue(withIdentifier: "UserSignedUp", sender: nil)
                self.firstNameTextField.text = nil
                self.nameTextField.text = nil
            }
        }
        // Do any additional setup after loading the view.
        
        let addPhoto = UITapGestureRecognizer(target: self, action: #selector(handleAddPhoto))
        addPhotoView.addGestureRecognizer(addPhoto)
        addPhotoView.isUserInteractionEnabled = true
        
        imagePicker.delegate = self
    }
    
    @IBAction func didEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func nextStepOnboarding(_ sender: UIButton) {
        if let password = password, let email = email {
            if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                let firstName = firstNameTextField.text!
                let name = nameTextField.text!
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        debugPrint("Error creating user: \(error.localizedDescription)")
                    } else if let user = user {
                        var imgData: Data?
                        if self.profilePicture.image != nil {
                            imgData = self.profilePicture.image!.jpegData(compressionQuality: 0.8)
                        }
                        self.addUserToFireStore(id: user.user.uid, name: name, firstName: firstName, imgData: imgData)
                        if let imgData = imgData {
                            self.uploadImageToFirebaseStorage(data: imgData, userID: user.user.uid)
                        }
                    }
                }
                
            }
        }
    }
    
    
    private func addUserToFireStore(id: String, name: String, firstName: String, imgData: Data?) {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        var refUser: DocumentReference? = nil
        if let imgData = imgData {
            refUser = db.collection("Users").addDocument(data: [
                "firstName": firstName,
                "lastName": name,
                "email": email,
                "userID": id,
                "imagePath": "userPhotos/\(id)/user.jpg"
            ]) {err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(refUser!.documentID)")
                }
            }
        } else {
            refUser = db.collection("Users").addDocument(data: [
                "firstName": firstName,
                "lastName": name,
                "email": email,
                "userID": id,
                "imagePath": "userPhotos/standard-avatar.png"
            ]) {err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(refUser!.documentID)")
                }
            }
        }
     
    }
    
    @objc private func handleAddPhoto() {
        let alert = UIAlertController(title: "Kies een afbeelding", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Bibliotheek", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let mediaType: String = info[UIImagePickerController.InfoKey.mediaType] as? String else {
            return
        }
        if mediaType == "public.image" {
            if let originalImage = info[.originalImage] as? UIImage {
                addPhotoView.isHidden = true
                let imageData = originalImage.jpegData(compressionQuality: 0.8)
                let selectedPhoto = info[.originalImage] as! UIImage
                self.profilePicture.isHidden = false
                self.changePhotoButton.isHidden = false
                self.profilePicture.image = selectedPhoto
                self.profilePicture.layer.masksToBounds = false
                self.profilePicture.layer.borderColor = #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.5843137255, alpha: 1)
                self.profilePicture.borderWidth = 1.0
                self.profilePicture.cornerRadius = self.profilePicture.frame.size.width/2
                self.profilePicture.clipsToBounds = true
            }
        }
    }
    
private func uploadImageToFirebaseStorage(data: Data, userID: String) {
    let storageRef = Storage.storage().reference()
    let uploadMetadata = StorageMetadata()
    uploadMetadata.contentType = "image/jpeg"
    let imageRef = storageRef.child("userPhotos")
    let imageRefofRef = imageRef.child(userID)
    let fileName = "user.jpg"
    let spaceRef = imageRefofRef.child(fileName)
    let uploadTask = spaceRef.putData(data, metadata: uploadMetadata) { (metadata, error) in
        if let error = error {
            print("error uploading \(error)")
            return
        } else {
           
        }
    }
    
}
    
    @IBAction func wijzigPhoto(_ sender: UIButton) {
        handleAddPhoto()
    }
    
@IBAction func goBack(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
}

//    if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
//    Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { user, error in
//    if error == nil {
//    Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!)
//    }
//    }
//    }
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

}
