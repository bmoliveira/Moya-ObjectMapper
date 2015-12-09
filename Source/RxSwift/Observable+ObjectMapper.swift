//
//  Observable+MoyaObjectMapper.swift
//
//  Created by Ivan Bruel on 09/12/15.
//  Copyright © 2015 Ivan Bruel. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper

/// Extension for processing Responses into Mappable objects through ObjectMapper
extension ObservableType where E == Response {

  /// Maps data received from the signal into an object which implements the Mappable protocol.
  /// If the conversion fails, the signal errors.
  func mapObjectMapper<T: Mappable>() -> Observable<T> {
    return flatMap { response -> Observable<T> in
      return just(try response.mapObjectMapper())
    }
  }

  /// Maps data received from the signal into an array of objects which implement the Mappable
  /// protocol.
  /// If the conversion fails, the signal errors.
  func mapObjectMapper<T: Mappable>() -> Observable<[T]> {
    return flatMap { response -> Observable<[T]> in
      return just(try response.mapObjectMapper())
    }
  }
}
