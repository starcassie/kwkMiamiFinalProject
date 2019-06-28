//
//  ProfileViewController.swift
//  TrainerBag
//
//  Created by Apple on 6/28/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var photos: [Photos] = []
    
    func getPhotos() {
        if let context =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataPhotos = try? context.fetch(Photos.fetchRequest()) as? [Photos] {
                photos = coreDataPhotos
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPhotos()
        if (!photos.isEmpty) {
            if let imageData = photos[photos.count - 1].photo {
                pfp.image = UIImage(data: imageData)
            }
            pfp.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            info.text = "name: \(photos[photos.count - 1].name!)\nbio: \(photos[photos.count - 1].bio!)"
        }
    }
    
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var pfp: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
