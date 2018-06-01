import UIKit
import Moya_ObjectMapper

class ViewController: UITableViewController {
    var repos = [Repository]()

    override func viewDidLoad() {
        super.viewDidLoad()

        downloadRepositories("ivanbruel")
    }

    // MARK: - API Stuff

    func downloadRepositories(_ username: String) {
        GitHubProvider.request(.userRepositories(username), completion: { result in

            var success = true
            var message = "Unable to fetch from GitHub"
            
            switch result {
            case let .success(response):
                do {
                    let repos: [Repository]? = try response.mapArray(Repository.self)
                    if let repos = repos {
                        // Presumably, you'd parse the JSON into a model object. This is just a demo, so we'll keep it as-is.
                        self.repos = repos
                    } else {
                        success = false
                    }
                } catch {
                    success = false
                }
                self.tableView.reloadData()
            case let .failure(error):
                guard let description = error.errorDescription else {
                    break
                }
                message = description
                success = false
            }
            
            if !success {
                let alertController = UIAlertController(title: "GitHub Fetch", message: message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                  alertController.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(ok)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }

    func downloadZen() {
        GitHubProvider.request(.zen, completion: { result in
            var message = "Couldn't access API"
            if case let .success(response) = result {
                message = (try? response.mapString()) ?? message
            }

            let alertController = UIAlertController(title: "Zen", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
              alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
        })
    }

    // MARK: - User Interaction

    @IBAction func searchWasPressed(_ sender: UIBarButtonItem) {
        var usernameTextField: UITextField?

        let promptController = UIAlertController(title: "Username", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if let usernameTextField = usernameTextField {
                self.downloadRepositories(usernameTextField.text!)
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
        downloadZen()
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        let repo = repos[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = repo.name
        return cell
    }
}

