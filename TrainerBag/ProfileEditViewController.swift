//
//  ProfileEditViewController.swift
//  TrainerBag
//
//  Created by Apple on 6/28/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProfileEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var newScreen = UIImagePickerController()
    
    var photos: [Photos] = []
    
    func getPhotos() {
        if let context =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataPhotos = try? context.fetch(Photos.fetchRequest()) as? [Photos] {
                photos = coreDataPhotos
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newScreen.delegate = self
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        getPhotos()
        if (!photos.isEmpty) {
            if let data = photos[photos.count - 1].photo {
                pfp.image = UIImage(data: data)
            }
            pfp.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            name.text = photos[photos.count - 1].name!
            bio.text = photos[photos.count - 1].bio!
        }

    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBOutlet weak var pfp: UIImageView!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var bio: UITextView!
    
    @IBAction func openCamera(_ sender: UIButton) {
        newScreen.sourceType = .camera
        present(newScreen, animated: true, completion:  nil)
    }
    
    @IBAction func openLibrary(_ sender: UIButton) {
        newScreen.sourceType = .photoLibrary
        present(newScreen, animated: true, completion: nil)
    }
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pfp.image = selectedImage
        }
        newScreen.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let photoToSave = Photos(entity: Photos.entity(), insertInto: context)
            photoToSave.name = name.text
            photoToSave.bio = bio.text
            if let userImage = pfp.image {
                if let userImageData = userImage.pngData() {
                    photoToSave.photo =  userImageData
                }
            }
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        navigationController?.popViewController(animated: true)
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
