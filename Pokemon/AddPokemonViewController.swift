//
//  AddPokemonViewController.swift
//  Pokemon
//
//  Created by Wei Xu on 2020-05-24.
//  Copyright © 2020 Georgebrown. All rights reserved.
//

import UIKit
import CoreData

class AddPokemonViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // type
    let typeItems = ["normal", "fire", "water", "grass", "electric"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeItems.count;
    }
    
    // what should actaully be displayed in the pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeItems[row]
    }
    
    // MARK: Outlets
    @IBOutlet weak var typePickerView: UIPickerView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var imageTxt: UITextField!
    @IBOutlet weak var basePointTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.typePickerView.delegate = self
        self.typePickerView.dataSource = self
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func rerollBtnPressed(_ sender: Any) {
        basePointTxt.text="\(Int.random(in: 50...250))"
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        if(nameTxt.text=="" || imageTxt.text=="" || basePointTxt.text=="") {
            let box = UIAlertController(
                title: "Input Error",
                message: "Please input all the items!",
                preferredStyle: .alert
            )
            box.addAction(
                UIAlertAction(title:"OK", style: .default, handler:nil)
            )
            self.present(box, animated:true)
            return
        } else {
            let intBasePoint = Int(basePointTxt.text!)!
            if(intBasePoint<50 || intBasePoint>250) {
                let box = UIAlertController(
                    title: "Input Error",
                    message: "Base point must between 50 to 250!",
                    preferredStyle: .alert
                )
                box.addAction(
                    UIAlertAction(title:"OK", style: .default, handler:nil)
                )
                self.present(box, animated:true)
                return
            } else {
                let db = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
                let pkmon = Pokemon(context: db)
                
                pkmon.name = nameTxt.text
                pkmon.photo = imageTxt.text
                
                let selectedIndex = self.typePickerView.selectedRow(inComponent: 0)
                pkmon.type = typeItems[selectedIndex]
                
                pkmon.base_experience_points = Int16(basePointTxt.text!)!
                
                do {
                    try db.save()
                    
                    let box = UIAlertController(
                        title: "Save success",
                        message: "Pokemon has been saved!",
                        preferredStyle: .alert
                    )
                    box.addAction(
                        UIAlertAction(title:"OK", style: .default, handler:nil)
                    )
                    self.present(box, animated:true)
                    
                } catch {
                    print("Cannot save to a table")
                }
            }
        }
        
    }
}
