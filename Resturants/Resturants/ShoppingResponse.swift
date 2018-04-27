//
//  ShoppingResponse.swift
//  Resturants
//
//  Created by Mark on 4/26/18.
//  Copyright © 2018 qin. All rights reserved.
//

import Foundation

struct ShoppingResponse: Codable{
    var ingredients: [ShoppingItem]
    var recipes: [Recipe]
}
