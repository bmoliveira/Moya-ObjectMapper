//
//  ViewController.swift
//  Demo-ReactiveSwift
//
//  Created by Robin Picard on 12/04/2019.
//  Copyright © 2019 Ash Furrow. All rights reserved.
//

import Moya
import ReactiveCocoa
import ReactiveSwift
import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var zenButton: UIBarButtonItem!
  @IBOutlet weak var searchButton: UIBarButtonItem!
  @IBOutlet var tableView: UITableView! {
    didSet {
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
      tableView.dataSource = self
      tableView.reactive.reloadData <~ viewModel.reloadDataSignal
    }
  }

  private let viewModel: ReactiveDemoViewModel = ReactiveDemoViewModel(networking: GitHubProvider)

  override func viewDidLoad() {
    super.viewDidLoad()
    initializeViewModel()
  }

  fileprivate func initializeViewModel() {
    viewModel.downloadZenSignal.observeValues { [weak self] result in
      switch result {
      case .success(let value): self?.showMessage(message: value)
      case .failure(let error): self?.showError(error: error)
      }
    }

    viewModel.downloadRepoSignal.observeValues { [weak self] result in
      switch result {
      case .success: break
      case .failure: self?.presentUsernamePrompt()
      }
    }

    viewModel.downloadRepositories(username: "p-rob")
  }
  
  fileprivate func showError(error: Error) {
    let alert = UIAlertController(title: "An error has occured!", message: error.localizedDescription, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
      alert.dismiss(animated: true, completion: nil)
    })
    alert.addAction(ok)
    self.present(alert, animated: true, completion: nil)
  }
  
  fileprivate func showMessage(message: String) {
    let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
      alert.dismiss(animated: true, completion: nil)
    })
    alert.addAction(ok)
    self.present(alert, animated: true, completion: nil)
  }

  fileprivate func presentUsernamePrompt() {
    var usernameTextField: UITextField?

    let promptController = UIAlertController(title: "Username", message: nil, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
      if let username = usernameTextField?.text {
        self?.viewModel.downloadRepositories(username: username)
      }
    })
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    promptController.addAction(ok)
    promptController.addAction(cancel)
    promptController.addTextField { (textField) -> Void in
      usernameTextField = textField
    }
    present(promptController, animated: true, completion: nil)
  }

  // MARK: - User Interaction
  @IBAction func searchWasPressed(_ sender: UIBarButtonItem) {
    presentUsernamePrompt()
  }
  
  @IBAction func zenWasPressed(_ sender: UIBarButtonItem) {
    viewModel.downloadZen()
  }
}

extension ViewController: UITableViewDataSource {

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.datasource.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
    let repo = viewModel.datasource[indexPath.row]
    cell.textLabel?.text = repo.name
    return cell
  }
}
