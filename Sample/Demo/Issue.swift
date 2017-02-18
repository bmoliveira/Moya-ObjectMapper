//
//  Issue.swift
//  Demo
//
//  Created by Gustavo Perdomo on 2/17/17.
//  Copyright © 2017 Gustavo Perdomo. All rights reserved.
//

import Foundation
import ObjectMapper

class Issue: Mappable {
    var identifier: Int!
    var number: Int!
    var title: String!
    var body: String!
    
    // MARK: JSON
    required init?(map: Map) {
        if map.JSON["id"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        identifier <- map["id"]
        number <- map["number"]
        title <- map["title"]
        body <- map["body"]
    }
}
