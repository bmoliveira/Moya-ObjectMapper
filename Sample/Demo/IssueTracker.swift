//
//  IssueTracker.swift
//  Demo
//
//  Created by Gustavo Perdomo on 2/17/17.
//  Copyright © 2017 Gustavo Perdomo. All rights reserved.
//

import Foundation
import Moya

class IssueTracker {
    let provider = MoyaProvider<GitHub>()
    
    func findUserRepositories(name: String, completion: @escaping Moya.Completion) -> Cancellable {
        return self.provider.request(GitHub.repos(username: name), completion: completion)
    }
}
