//
//  Recipe.swift
//  Resturants
//
//  Created by Mark on 4/26/18.
//  Copyright © 2018 qin. All rights reserved.
//

import Foundation

struct Recipe:Codable {
    var id:Int
    var name:String
    var ingredients:String
    var url:String
}
