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
import Result

class ReactiveDemoViewModel: ReactiveExtensionsProvider {
  private let (_reloadDataSignal, reloadDataObserver) = Signal<Void, NoError>.pipe()
  private let (_downloadZenSignal, downloadZenObserver) = Signal<Result<String, MoyaError>, NoError>.pipe()
  private let (_downloadRepoSignal, downloadRepoObserver) = Signal<Result<[Repository], MoyaError>, NoError>.pipe()

  private var downloadRepositoriesDisposable: Disposable?
  private var downloadZenDisposable: Disposable?
  
  let networking: Reactive<MoyaProvider<GitHub>>
  var reloadDataSignal: Signal<Void, NoError> { return _reloadDataSignal }
  var downloadZenSignal: Signal<Result<String, MoyaError>, NoError> { return _downloadZenSignal }
  var downloadRepoSignal: Signal<Result<[Repository], MoyaError>, NoError> { return _downloadRepoSignal }

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
        self?.datasource = result.value ?? []
        self?.reloadDataObserver.send(value: ())
        self?.downloadRepoObserver.send(value: result)
      }
  }
}
