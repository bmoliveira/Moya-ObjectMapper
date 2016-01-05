//
//  Observable+ObjectMapper.swift
//
//  Created by Ivan Bruel on 09/12/15.
//  Copyright © 2015 Ivan Bruel. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

public extension Response {

  /// Maps data received from the signal into an object which implements the Mappable protocol.
  /// If the conversion fails, the signal errors.
  public func mapObjectMapper<T: Mappable>(type: T.Type) throws -> T {
    guard let object = Mapper<type>().map(try mapJSON()) else {
      throw Error.JSONMapping(self)
    }
   return object
  }

  /// Maps data received from the signal into an array of objects which implement the Mappable
  /// protocol.
  /// If the conversion fails, the signal errors.
  public func mapObjectMapper<T: Mappable>(type: T.Type) throws -> [T] {
    guard let objects = Mapper<type>().mapArray(try mapJSON()) else {
      throw Error.JSONMapping(self)
    }
    return objects
  }

}
