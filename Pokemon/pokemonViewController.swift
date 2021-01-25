//
//  pokemonViewController.swift
//  Pokemon
//
//  Created by Wei Xu on 2020-05-25.
//  Copyright © 2020 Georgebrown. All rights reserved.
//

import UIKit
import CoreData

class pokemonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PokemonCellDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var pokemonTableView: UITableView!
    
    var pokemons=[Pokemon]()
    var playerName=""
    var playerPhoto=""
    var playerPoint=""
    var playerType=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pokemonTableView.dataSource=self
        self.pokemonTableView.delegate=self
        
        // Do any additional setup after loading the view.
        
        let db = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request : NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Pokemon.name), ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            let results = try db.fetch(request)
            
            if results.count == 0 {
                print("no results found")
            }
            else {
                pokemons=results
            }
        } catch {
            print("Can not get data")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell") as? pokemonTableViewCell
        
        if (cell == nil) {
            cell = pokemonTableViewCell(style: .default, reuseIdentifier: "pokemonCell")
        }
        
        // setup the delegate
        cell?.delegate = self
        cell?.indexPath = indexPath      // this .indexPath is a member variable of the MovieTableCell class
        
        let pkm = pokemons[indexPath.row]
        
        cell?.nameLabel.text = pkm.name!
        cell?.typeLabel.text = pkm.type!
        cell?.basePointLabel.text = "\(pkm.base_experience_points)"
        cell?.photoImage.image = UIImage(named: pkm.photo!)
        
        return cell!
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // -----------------------------------------
    // MovieCell Delegate Function
    // -----------------------------------------
    func battleButtonPressed(at indexPath: IndexPath) {
        let pkm = pokemons[indexPath.row]
        playerName = pkm.name!
        playerPhoto = pkm.photo!
        playerPoint = "\(pkm.base_experience_points)"
        playerType = pkm.type!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fightController = segue.destination as! FightViewController
        fightController.playerName=playerName
        fightController.playerPhoto=playerPhoto
        fightController.playerBasePointer=playerPoint
        fightController.playerType=playerType
    }
}
