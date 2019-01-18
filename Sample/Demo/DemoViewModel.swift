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

class DemoViewModel {
  let networking: MoyaProvider<GitHub>
  var repositoriesResponse: ((Bool, String, [Repository]?) -> Void)? = nil
  var zenResponse: ((Bool, String) -> Void)? = nil
  
  init(networking: MoyaProvider<GitHub>) {
    self.networking = networking
  }
  
  func downloadRepositories(_ username: String) {
    networking.request(.userRepositories(username), completion: { [weak self] result  in
      var success = true
      var message = "Unable to fetch from GitHub"
      var repositores: [Repository]? = nil
      switch result {
      case let .success(response):
        do {
          let repos: [Repository]? = try response.mapArray(Repository.self)
          if let repos = repos {
            // Presumably, you'd parse the JSON into a model object. This is just a demo, so we'll keep it as-is.
            repositores = repos
          } else {
            success = false
          }
        } catch {
          success = false
        }
      case let .failure(error):
        guard let description = error.errorDescription else {
          break
        }
        message = description
        success = false
      }
      
      self?.repositoriesResponse?(success, message, repositores)
    })
  }

  func downloadZen() {
    networking.request(.zen, completion: { [weak self] result in
      var success = true
      var message = "Couldn't access API"
      if case let .success(response) = result {
        message = (try? response.mapString()) ?? message
      } else {
        success = false
      }
      self?.zenResponse?(success, message)
    })
  }
}
