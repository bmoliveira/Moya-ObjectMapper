import UIKit

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var zenButton: UIBarButtonItem!
  @IBOutlet weak var searchButton: UIBarButtonItem!
  @IBOutlet var tableView: UITableView!
  
  let viewModel = DemoViewModel(networking: GitHubProvider)
  
  var repos = [Repository]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    self.tableView.delegate = self
    initializeViewModel()
  }
  
  fileprivate func initializeViewModel() {
    viewModel.repositoriesResponse = { [weak self] (success, message, repos) in
      if (success) {
        self?.repos = repos ?? []
        self?.tableView.reloadData()
      } else {
        let alertController = UIAlertController(title: "GitHub Fetch", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
          alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(ok)
        self?.present(alertController, animated: true, completion: nil)
      }
    }
    
    viewModel.zenResponse = { [weak self] (success, message) in
      let alertController = UIAlertController(title: "Zen", message: message, preferredStyle: .alert)
      let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        alertController.dismiss(animated: true, completion: nil)
      })
      alertController.addAction(ok)
      self?.present(alertController, animated: true, completion: nil)
    }
    
    viewModel.downloadRepositories("ivanbruel")
  }
  
  // MARK: - User Interaction
  @IBAction func searchWasPressed(_ sender: UIBarButtonItem) {
    var usernameTextField: UITextField?
    
    let promptController = UIAlertController(title: "Username", message: nil, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
      if let usernameTextField = usernameTextField {
        self.viewModel.downloadRepositories(usernameTextField.text!)
      }
    })
    _ = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
    }
    promptController.addAction(ok)
    promptController.addTextField { (textField) -> Void in
      usernameTextField = textField
    }
    present(promptController, animated: true, completion: nil)
  }
  
  @IBAction func zenWasPressed(_ sender: UIBarButtonItem) {
    viewModel.downloadZen()
  }
  
  // MARK: - Table View
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
    
    let repo = repos[(indexPath as NSIndexPath).row]
    cell.textLabel?.text = repo.name
    return cell
  }
}

