//
//  RecipeCellTableViewCell.swift
//  Resturants
//
//  Created by Mark on 4/26/18.
//  Copyright © 2018 qin. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func setData(with r: Recipe) {
        nameLabel.text = r.name
        descriptionLabel.text = r.ingredients
    }
}
