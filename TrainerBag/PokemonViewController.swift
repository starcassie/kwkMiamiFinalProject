//
//  PokemonViewController.swift
//  TrainerBag
//
//  Created by Apple on 6/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    var pokemon: Pokemon? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if let realpokemon = pokemon {
            title = realpokemon.name
            info.text = "name: \(realpokemon.name!) \npersonality:  \( realpokemon.number!) \nnotes: \(realpokemon.gender!)"
            if let cellPokemonImageData = realpokemon.image {
                if let cellPokemonImageData = UIImage(data: cellPokemonImageData) {
                    pic.image = cellPokemonImageData
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var pic: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
