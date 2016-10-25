import ReactiveSwift
import Moya
import ObjectMapper

/// Extension for processing Responses into Mappable objects through ObjectMapper
extension SignalProducerProtocol where Value == Moya.Response, Error == Moya.Error {

  /// Maps data received from the signal into an object which implements the Mappable protocol.
  /// If the conversion fails, the signal errors.
<<<<<<< HEAD
  public func mapObject<T: Mappable>(_ type: T.Type) -> SignalProducer<T, Error> {
    return producer.flatMap(.latest) { response -> SignalProducer<T, Error> in
=======
  public func mapObject<T: BaseMappable>(_ type: T.Type) -> SignalProducer<T, Error> {
    return producer.flatMap(.Latest) { response -> SignalProducer<T, Error> in
>>>>>>> c76821a3899c2a31aa29f4da8cfe010bc7dcbdb6
      return unwrapThrowable { try response.mapObject(T) }
    }
  }

  /// Maps data received from the signal into an array of objects which implement the Mappable
  /// protocol.
  /// If the conversion fails, the signal errors.
<<<<<<< HEAD
  public func mapArray<T: Mappable>(_ type: T.Type) -> SignalProducer<[T], Error> {
    return producer.flatMap(.latest) { response -> SignalProducer<[T], Error> in
=======
  public func mapArray<T: BaseMappable>(_ type: T.Type) -> SignalProducer<[T], Error> {
    return producer.flatMap(.Latest) { response -> SignalProducer<[T], Error> in
>>>>>>> c76821a3899c2a31aa29f4da8cfe010bc7dcbdb6
      return unwrapThrowable { try response.mapArray(T) }
    }
  }
}

/// Maps throwable to SignalProducer
private func unwrapThrowable<T>(_ throwable: () throws -> T) -> SignalProducer<T, Moya.Error> {
  do {
    return SignalProducer(value: try throwable())
  } catch {
    return SignalProducer(error: error as! Moya.Error)
  }
}
