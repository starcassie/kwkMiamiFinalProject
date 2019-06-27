//
//  FirstPageTableViewController.swift
//  TrainerBag
//
//  Created by Apple on 6/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


class FirstPageTableViewController: UITableViewController {
    var pokemons: [Pokemon] = []
    
    func getPokemon() {
        if let context =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataPokemon = try? context.fetch(Pokemon.fetchRequest()) as? [Pokemon] {
                pokemons = coreDataPokemon
                tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell()
        let cellPokemon = pokemons[indexPath.row]
//        if let cellPokemonImageData = cellPokemon.image {
//            if let cellPokemonImage = UIImage(data: cellPokemonImageData) {
//                cell.picture?.image = cellPokemonImage
//            }
//        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPokemon()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToDetail", sender: pokemons[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToDetail"{
            if let pokemonDetailView = segue.destination as? PokemonViewController {
                if let pokemonToSend = sender as? Pokemon {
                    pokemonDetailView.pokemon = pokemonToSend
                }
            }
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let photoToDelete = pokemons[indexPath.row]
                context.delete(photoToDelete)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getPokemon()
            }
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
