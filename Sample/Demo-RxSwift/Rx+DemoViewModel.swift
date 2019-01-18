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

extension Reactive where Base: RxDemoViewModel {
  func downloadRepositories(_ username: String) -> Single<[Repository]> {
    return base.networking.rx.request(.userRepositories(username))
      .mapArray(Repository.self)
  }
  
  func downloadZen() -> Single<String> {
  return base.networking.rx.request(.zen)
    .mapString()
  }
}

