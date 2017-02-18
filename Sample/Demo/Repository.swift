//
//  Repository.swift
//  Demo
//
//  Created by Gustavo Perdomo on 2/17/17.
//  Copyright © 2017 Gustavo Perdomo. All rights reserved.
//

import Foundation
import ObjectMapper

class Repository: Mappable {
    var identifier: Int!
    var language: String!
    var name: String!
    var fullName: String!
    
    // MARK: JSON
    required init?(map: Map) {
        if map.JSON["id"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        identifier <- map["id"]
        language <- map["language"]
        name <- map["name"]
        fullName <- map["full_name"]
    }
}
