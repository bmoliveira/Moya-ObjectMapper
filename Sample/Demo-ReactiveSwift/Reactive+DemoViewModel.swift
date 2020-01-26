//
//  DemoViewModel.swift
//  Demo-ReactiveSwift
//
//  Created by Robin Picard on 12/04/2019.
//  Copyright © 2019 Ash Furrow. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import ReactiveSwift

extension Reactive where Base: ReactiveDemoViewModel {
  func downloadRepositories(_ username: String) -> SignalProducer<[Repository], MoyaError> {
    return base.networking.request(.userRepositories(username))
      .mapArray(Repository.self)
  }
  
  func downloadZen() -> SignalProducer<String, MoyaError> {
    return base.networking.request(.zen)
      .mapString()
  }
}

