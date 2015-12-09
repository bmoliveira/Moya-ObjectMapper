Moya+ObjectMapper
============
[![CocoaPods](https://img.shields.io/cocoapods/v/Moya-ObjectMapper.svg)](https://github.com/ivanbruel/Moya-ObjectMapper)

[ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) bindings for
[Moya](https://github.com/Moya/Moya) for easier JSON serialization.
Includes [RxSwift](https://github.com/ReactiveX/RxSwift/) bindings as well.

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

## Without RxSwift


```swift
GitHubProvider.request(.UserRepositories(username), completion: { result in

    var success = true
    var message = "Unable to fetch from GitHub"

    switch result {
    case let .Success(response):
        do {
            if let repos: [Repository]? = try response.mapObjectMapper() {
              self.respos = repos
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

## With RxSwift

```swift
GitHubProvider.request(.UserRepositories(username)).mapObjectMapper()
  .subscribe {
    (event: Event<[Repository]>) -> Void in
    switch event {
    case .Next(let repos):
      self.repos = repos
    case .Error(let error):
      print(error)
    default:
      break
    }
  }
```

# License

Moya-ObjectMapper is released under an MIT license. See LICENSE for more information.
