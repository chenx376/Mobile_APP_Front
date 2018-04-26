//
//  ShoppingItem.swift
//  Resturants
//
//  Created by Mark on 4/26/18.
//  Copyright © 2018 qin. All rights reserved.
//

import Foundation


struct ShoppingItem: Codable {
    var name: String
    
    init(_ name:String) {
        self.name = name
    }
}
