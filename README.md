Moya-ObjectMapper
============
[![CocoaPods](https://img.shields.io/cocoapods/v/Moya-ObjectMapper.svg)](https://github.com/ivanbruel/Moya-ObjectMapper)

[ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) bindings for
[Moya](https://github.com/Moya/Moya) for easier JSON serialization.
Includes [RxSwift](https://github.com/ReactiveX/RxSwift/) bindings as well.

# Installation

## CocoaPods

```ruby
pod 'Moya-ObjectMapper', '~> 1.3'
```

The subspec if you want to use the bindings over RxSwift.

```ruby
pod 'Moya-ObjectMapper/RxSwift', '~> 1.3'
```

And the subspec if you want to use the bindings over ReactiveCocoa.

```ruby
pod 'Moya-ObjectMapper/ReactiveCocoa', '~> 1.3'
```

# Usage

Create a `Class` or `Struct` which implements the `Mappable` protocol.

```swift
import Foundation
import ObjectMapper

// MARK: Initializer and Properties
struct Repository: Mappable {

  var identifier: Int!
  var language: String?
  var url: String!

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    identifier <- map["id"]
    language <- map["language"]
    url <- map["url"]
  }

}
```

## 1. Without RxSwift


```swift
GitHubProvider.request(.UserRepositories(username), completion: { result in

    var success = true
    var message = "Unable to fetch from GitHub"

    switch result {
    case let .Success(response):
        do {
            if let repos = try response.mapArray(Repository) {
              self.repos = repos
            } else {
              success = false
            }
        } catch {
            success = false
        }
        self.tableView.reloadData()
    case let .Failure(error):
        guard let error = error as? CustomStringConvertible else {
            break
        }
        message = error.description
        success = false
    }
})

```

## 2. With RxSwift

```swift
GitHubProvider.request(.UserRepositories(username))
  .mapArray(Repository)
  .subscribe { event -> Void in
    switch event {
    case .Next(let repos):
      self.repos = repos
    case .Error(let error):
      print(error)
    default:
      break
    }
  }.addDisposableTo(disposeBag)
```

# Contributing

Issues and pull requests are welcome!

# Author

Ivan Bruel [@ivanbruel](https://twitter.com/ivanbruel)

# License

Moya-ObjectMapper is released under an MIT license. See LICENSE for more information.
