//
//  BattleResultViewController.swift
//  Pokemon
//
//  Created by Wei Xu on 2020-05-26.
//  Copyright © 2020 Georgebrown. All rights reserved.
//

import UIKit
import CoreData

class BattleResultViewController: UIViewController {

    var battles=[Battle]()
    
    
    // MARK: Outlets
    @IBOutlet weak var battleResultTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let db = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let request : NSFetchRequest<Battle> = Battle.fetchRequest()
            
            do {
                let results = try db.fetch(request)
                
                if results.count == 0 {
                    print("no results found")
                }
                else {
                    battles=results
                    
                    var battleResult=""
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd h:mm:ss a"
                    for bte in battles {
                        let dataFormmattered = formatter.string(from: bte.battle_date_time!)
                        let pokemon = bte.winner_pokemon! as Pokemon
                        print(pokemon)
                        //battleResult = "\(battleResult) \(dataFormmattered)     \(bte.winner_pokemon?.name!) wins \n"
                    }
                    battleResultTxt.text=battleResult
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

}
