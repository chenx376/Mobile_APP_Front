//
//  ShoppingItemCell.swift
//  Resturants
//
//  Created by Mark on 4/26/18.
//  Copyright © 2018 qin. All rights reserved.
//

import UIKit

class ShoppingItemCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setData(with si: ShoppingItem) {
       nameLabel.text = si.name
    }

}
