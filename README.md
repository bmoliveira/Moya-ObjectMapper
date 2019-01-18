Moya-ObjectMapper
============
[![CocoaPods](https://img.shields.io/cocoapods/v/Moya-ObjectMapper.svg)](https://github.com/bmoliveira/Moya-ObjectMapper)
![Swift 4.2](https://img.shields.io/badge/Swift-4.2-blue.svg)

[ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) bindings for
[Moya](https://github.com/Moya/Moya) for easier JSON serialization.
Includes [RxSwift](https://github.com/ReactiveX/RxSwift/) bindings as well.

# Installation

## CocoaPods

```ruby
pod 'Moya-ObjectMapper'
```

The subspec if you want to use the bindings over RxSwift.

```ruby
pod 'Moya-ObjectMapper/RxSwift'
```

The subspec if you want to use the bindings over ReactiveSwift.

```ruby
pod 'Moya-ObjectMapper/ReactiveSwift'
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
  init?(map: Map) { }

  mutating func mapping(map: Map) {
    identifier <- map["id"]
    language <- map["language"]
    url <- map["url"]
  }

}
```

## 1. Without RxSwift and ReactiveSwift

```swift
GitHubProvider.request(.userRepositories(username), completion: { result in

    var success = true
    var message = "Unable to fetch from GitHub"

    switch result {
    case let .success(response):
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
    case let .failure(error):
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
GitHubProvider.request(.userRepositories(username))
  .mapArray(Repository.self)
  .subscribe { event -> Void in
    switch event {
    case .next(let repos):
      self.repos = repos
    case .error(let error):
      print(error)
    default: break
    }
  }.addDisposableTo(disposeBag)
```


## 2. With ReactiveSwift

```swift
GitHubProvider.request(.userRepositories(username))
  .mapArray(Repository.self)
  .start { event in
    switch event {
    case .value(let repos):
      self.repos = repos
    case .failed(let error):
      print(error)
    default: break
    }
  }
```

# Contributing

Issues and pull requests are welcome!

# Author

Ivan Bruel [@ivanbruel](https://twitter.com/ivanbruel)

# Maintainers

Bruno Oliveira [@bmoliveira](https://twitter.com/bmoliveira)


# License

Moya-ObjectMapper is released under an MIT license. See LICENSE for more information.
