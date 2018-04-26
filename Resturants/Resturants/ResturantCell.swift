//
//  ResturantCell.swift
//  Resturants
//
//  Created by qin on 4/21/18.
//  Copyright © 2018 qin. All rights reserved.
//

import UIKit

class ResturantCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    func setData(with resturant: Resturant) {
        nameLabel.text = resturant.name
        rateLabel.text = "Rating: \(resturant.rate)"
        reviewsLabel.text = "\(resturant.reviews) Reviews"
        contentsLabel.text = resturant.contents
        locationLabel.text = resturant.location
        phoneLabel.text = resturant.phone
    }

}
