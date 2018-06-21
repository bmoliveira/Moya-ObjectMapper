import ReactiveSwift
import Moya
import ObjectMapper

/// Extension for processing Responses into Mappable objects through ObjectMapper
extension SignalProducerProtocol where Value == Moya.Response, Error == MoyaError {

    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    public func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> SignalProducer<T, MoyaError> {
        return producer.flatMap(.latest) {
            (response: Response) -> SignalProducer<T, Error> in
            return unwrapThrowable { try response.mapObject(type, context: context) }
        }
    }

    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    public func mapArray<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> SignalProducer<[T], MoyaError> {
        return producer.flatMap(.latest) { (response: Response) -> SignalProducer<[T], Error> in
            return unwrapThrowable { try response.mapArray(type, context: context) }
        }
    }

    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
  public func mapObject<T: BaseMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) -> SignalProducer<T, MoyaError> {
        return producer.flatMap(.latest) {
            (response: Response) -> SignalProducer<T, Error> in
          return unwrapThrowable { try response.mapObject(type, atKeyPath: keyPath, context: context) }
        }
    }

    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    public func mapArray<T: BaseMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) -> SignalProducer<[T], MoyaError> {
        return producer.flatMap(.latest) { (response: Response) -> SignalProducer<[T], Error> in
            return unwrapThrowable { try response.mapArray(type, atKeyPath: keyPath, context: context) }
        }
    }
}

/// Maps throwable to SignalProducer
private func unwrapThrowable<T>(_ throwable: () throws -> T) -> SignalProducer<T, MoyaError> {
    do {
        return SignalProducer(value: try throwable())
    } catch {
        return SignalProducer(error: error as! MoyaError)
    }
}
