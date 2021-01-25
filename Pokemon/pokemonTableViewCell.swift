//
//  pokemonTableViewCell.swift
//  Pokemon
//
//  Created by Wei Xu on 2020-05-25.
//  Copyright © 2020 Georgebrown. All rights reserved.
//

import UIKit

class pokemonTableViewCell: UITableViewCell {

     // MARK: Outlets
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var basePointLabel: UILabel!
    
    @IBAction func battlePressed(_ sender: Any) {
        self.delegate?.battleButtonPressed(at: indexPath)
    }
    
    // MARK: Delegate
    var delegate:PokemonCellDelegate?
    var indexPath:IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// Define the delegate
protocol PokemonCellDelegate {
    func battleButtonPressed(at indexPath:IndexPath)
}
