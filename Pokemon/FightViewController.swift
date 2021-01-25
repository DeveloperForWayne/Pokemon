//
//  FightViewController.swift
//  Pokemon
//
//  Created by Wei Xu on 2020-05-26.
//  Copyright © 2020 Georgebrown. All rights reserved.
//

import UIKit
import CoreData

class FightViewController: UIViewController {
    
    var playerName=""
    var playerPhoto=""
    var playerBasePointer=""
    var playerType=""
    var pokemons=[Pokemon]()
    
    // MARK: Outlets
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPhotoImg: UIImageView!
    @IBOutlet weak var playerBasePointLabel: UILabel!
    
    @IBOutlet weak var computerNameLabel: UILabel!
    @IBOutlet weak var ComputerPhotoImg: UIImageView!
    @IBOutlet weak var ComputerBasePointLabel: UILabel!
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        playerNameLabel.text = playerName
        playerBasePointLabel.text = playerBasePointer
        playerPhotoImg.image = UIImage(named: playerPhoto)
        
        let db = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request : NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        let query = NSPredicate(format: "name <> %@", playerName)
        request.predicate = query
        
        do {
            let results = try db.fetch(request)
            
            if results.count == 0 {
                print("no results found")
            }
            else {
                pokemons=results
                
                let randomIndex = Int.random(in: 0...results.count-1)
                let cPokemon = pokemons[randomIndex]
                
                computerNameLabel.text = cPokemon.name
                ComputerBasePointLabel.text = "\(cPokemon.base_experience_points)"
                ComputerPhotoImg.image = UIImage(named: cPokemon.photo!)
                
                let pokemon = Pokemon(context:db)
                
                if(Int16(playerBasePointer)! > cPokemon.base_experience_points) {
                    winnerLabel.text="Player wins!"
                    pokemon.name = playerName
                    pokemon.photo = playerPhoto
                    pokemon.base_experience_points = Int16(playerBasePointer)!
                    pokemon.type = playerType
                } else if (Int16(playerBasePointer)! < cPokemon.base_experience_points) {
                    winnerLabel.text="Computer wins!"
                    pokemon.name = cPokemon.name
                    pokemon.photo = cPokemon.photo
                    pokemon.base_experience_points = cPokemon.base_experience_points
                    pokemon.type = cPokemon.type
                } else {
                    winnerLabel.text="Tie!"
                    pokemon.name = playerName
                    pokemon.photo = playerPhoto
                    pokemon.base_experience_points = Int16(playerBasePointer)!
                    pokemon.type = playerType
                }
                
                let battle = Battle(context: db)
                battle.battle_date_time = Date()
                battle.winner_pokemon=pokemon
                
                deletePokemon(name: pokemon.name!)
                
                do {
                    try db.save()
                } catch {
                    print("Cannot save to a table")
                }
                
            }
            
        } catch {
            print("Can not get data")
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
    
    func deletePokemon(name: String) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
          let fetchRequest : NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
          let query = NSPredicate(format: "name = %@", name)
          fetchRequest.predicate = query
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = results[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
            }
            catch {
                print(error)
            }
        }
        catch{
            print(error)
        }
    }
    
}
