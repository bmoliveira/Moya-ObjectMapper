//
//  DemoViewModel.swift
//  Demo-ReactiveSwift
//
//  Created by Robin Picard on 12/04/2019.
//  Copyright © 2019 Ash Furrow. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import ReactiveSwift

class ReactiveDemoViewModel: ReactiveExtensionsProvider {
  private let (_reloadDataSignal, reloadDataObserver) = Signal<Void, Never>.pipe()
  private let (_downloadZenSignal, downloadZenObserver) = Signal<Result<String, MoyaError>, Never>.pipe()
  private let (_downloadRepoSignal, downloadRepoObserver) = Signal<Result<[Repository], MoyaError>, Never>.pipe()

  private var downloadRepositoriesDisposable: Disposable?
  private var downloadZenDisposable: Disposable?
  
  let networking: Reactive<MoyaProvider<GitHub>>
  var reloadDataSignal: Signal<Void, Never> { return _reloadDataSignal }
  var downloadZenSignal: Signal<Result<String, MoyaError>, Never> { return _downloadZenSignal }
  var downloadRepoSignal: Signal<Result<[Repository], MoyaError>, Never> { return _downloadRepoSignal }

  private(set) var datasource: [Repository] = []
  
  init(networking: MoyaProvider<GitHub>) {
    self.networking = networking.reactive
  }

  func downloadZen() {
    downloadZenDisposable?.dispose()
    downloadZenDisposable = reactive.downloadZen()
      .startWithResult { [weak self] result in
        self?.downloadZenObserver.send(value: result)
      }
  }

  func downloadRepositories(username: String) {
    downloadRepositoriesDisposable?.dispose()
    downloadRepositoriesDisposable = reactive.downloadRepositories(username)
      .startWithResult { [weak self] result in
        if case let .success(value) = result {
            self?.datasource = value
        } else {
            self?.datasource = []
        }
        self?.reloadDataObserver.send(value: ())
        self?.downloadRepoObserver.send(value: result)
      }
  }
}
