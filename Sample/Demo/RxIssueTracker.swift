//
//  RxIssueTracker.swift
//  Demo
//
//  Created by Gustavo Perdomo on 2/17/17.
//  Copyright © 2017 Gustavo Perdomo. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxOptional
import Moya_ObjectMapper

class RxIssueTracker {
    let provider = RxMoyaProvider<GitHub>()
    let repositoryName: Observable<String>
    
    init(name: Observable<String>) {
        self.repositoryName = name
    }
    
    func trackIssues() -> Observable<[Issue]> {
        return self.repositoryName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { name -> Observable<Repository?> in
                print("Name: \(name)")
                return self.findRepository(name: name)
            }
            .flatMapLatest { repository -> Observable<[Issue]?> in
                guard let repository = repository else { return Observable.just(nil) }
                
                print("Repository: \(repository.fullName)")
                return self.findIssues(repository: repository)
            }
            .replaceNilWith([])
    }
    
    internal func findIssues(repository: Repository) -> Observable<[Issue]?> {
        return self.provider
            .request(GitHub.issues(repositoryFullName: repository.fullName!))
            .debug()
            .mapArrayOptional(Issue.self)
    }
    
    internal func findRepository(name: String) -> Observable<Repository?> {
        return self.provider
            .request(GitHub.repo(fullName: name))
            .debug()
            .mapObjectOptional(Repository.self)
    }
}
