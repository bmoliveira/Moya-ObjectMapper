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
	public func mapObject<T: Mappable>(type: T.Type) throws -> T {
		guard let object = Mapper<T>().map(try mapJSON()) else {
			throw Error.JSONMapping(self)
		}
		return object
	}
	
	// Map an object that sits at a non-empty keyPath inside the response JSON
	public func mapObject<T: Mappable>(type: T.Type, withKeyPath keyPath: String?) throws -> T {
		guard let keyPath = keyPath else { return try mapObject(type) }
		
		guard let jsonDictionary = try mapJSON() as? NSDictionary,
			let objectDictionary = jsonDictionary.valueForKeyPath(keyPath) as? NSDictionary,
			let object = Mapper<T>().map(objectDictionary) else {
				throw Error.JSONMapping(self)
		}
		return object
	}
	
	/// Maps data received from the signal into an array of objects which implement the Mappable
	/// protocol.
	/// If the conversion fails, the signal errors.
	public func mapArray<T: Mappable>(type: T.Type) throws -> [T] {
		guard let objects = Mapper<T>().mapArray(try mapJSON()) else {
			throw Error.JSONMapping(self)
		}
		return objects
	}
	
	// Map an array that sits at a non-empty keyPath inside the response JSON
	public func mapArray<T: Mappable>(type: T.Type, withKeyPath keyPath: String?) throws -> [T] {
		guard let keyPath = keyPath else { return try mapArray(type) }
		
		guard let jsonDictionary = try mapJSON() as? NSDictionary,
			let objectArray = jsonDictionary.valueForKeyPath(keyPath) as? NSArray,
			let objects = Mapper<T>().mapArray(objectArray) else {
				throw Error.JSONMapping(self)
		}
		return objects
	}
	
}
