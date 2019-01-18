//
//  DemoViewModel.swift
//  Demo
//
//  Created by Bruno Oliveira on 17/01/2019.
//  Copyright © 2019 Ash Furrow. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import RxSwift

class RxDemoViewModel: ReactiveCompatible {
  let networking: MoyaProvider<GitHub>
  
  init(networking: MoyaProvider<GitHub>) {
    self.networking = networking
  }
}
