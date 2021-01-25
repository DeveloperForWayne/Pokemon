//
//  Battle+CoreDataProperties.swift
//  Pokemon
//
//  Created by Wei Xu on 2020-05-26.
//  Copyright © 2020 Georgebrown. All rights reserved.
//
//

import Foundation
import CoreData


extension Battle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Battle> {
        return NSFetchRequest<Battle>(entityName: "Battle")
    }

    @NSManaged public var battle_date_time: Date?
    @NSManaged public var winner_pokemon: Pokemon?

}
