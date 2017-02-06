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
public extension ObservableType where E == Response {

  /// Maps data received from the signal into an object
  /// which implements the Mappable protocol and returns the result back
  /// If the conversion fails, the signal errors.
	public func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<T> {
    return flatMap { response -> Observable<T> in
		return Observable.just(try response.mapObject(T.self, context: context))
      }
  }

  /// Maps data received from the signal into an array of objects
  /// which implement the Mappable protocol and returns the result back
  /// If the conversion fails, the signal errors.
	public func mapArray<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<[T]> {
    return flatMap { response -> Observable<[T]> in
		return Observable.just(try response.mapArray(T.self, context: context))
      }
  }
}


// MARK: - ImmutableMappable

public extension ObservableType where E == Response {

  /// Maps data received from the signal into an object
  /// which implements the ImmutableMappable protocol and returns the result back
  /// If the conversion fails, the signal errors.
  public func mapObject<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<T> {
    return flatMap { response -> Observable<T> in
		return Observable.just(try response.mapObject(T.self, context: context))
      }
  }

  /// Maps data received from the signal into an array of objects
  /// which implement the ImmutableMappable protocol and returns the result back
  /// If the conversion fails, the signal errors.
  public func mapArray<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<[T]> {
    return flatMap { response -> Observable<[T]> in
		return Observable.just(try response.mapArray(T.self, context: context))
      }
  }
}
