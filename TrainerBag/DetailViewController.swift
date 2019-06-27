//
//  DetailViewController.swift
//  TrainerBag
//
//  Created by Apple on 6/26/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        newScreen.delegate = self
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var nameInfo: UITextField!
    @IBOutlet weak var numberInfo: UITextField!
    @IBOutlet weak var genderInfo: UITextField!
    var newScreen = UIImagePickerController()
    @IBAction func openCamera(_ sender: UIButton) {
        newScreen.sourceType = .camera
        present(newScreen, animated: true, completion: nil)
    }
    
    @IBAction func openLibrary(_ sender: UIButton) {
        newScreen.sourceType = .photoLibrary
        present(newScreen, animated: true, completion: nil)
    }
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage.image = selectedImage
            // add crop later
        }
        newScreen.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton(_ sender: UIButton) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let pokemonToSave = Pokemon(entity: Pokemon.entity(), insertInto: context)
            pokemonToSave.name = nameInfo.text
            pokemonToSave.number = numberInfo.text
            pokemonToSave.gender = genderInfo.text
            if let userImage = newImage.image {
                if let userImageData = userImage.pngData() {
                    pokemonToSave.image =  userImageData
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
