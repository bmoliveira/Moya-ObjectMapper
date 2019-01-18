//
//  DemoRequestable.swift
//  Demo
//
//  Created by Bruno Oliveira on 17/01/2019.
//  Copyright © 2019 Ash Furrow. All rights reserved.
//

import Foundation
import Moya

protocol DemoRequestable {
  var networking: MoyaProvider<GitHub> {get}
}
