//
//  MoyaViewController.swift
//  Demo
//
//  Created by Gustavo Perdomo on 2/17/17.
//  Copyright © 2017 Gustavo Perdomo. All rights reserved.
//

import UIKit

class MoyaViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var manager = IssueTracker()
    var repositories = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self
        searchBar.placeholder = "Github Username and press Search"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_: UISearchBar) {
        searchBar.resignFirstResponder()
        
        _ = manager.findUserRepositories(name: self.searchBar.text!, completion: { result in
            var success = true
            var message = "Unable to fetch from GitHub"
            
            switch result {
            case let .success(response):
                do {
                    self.repositories = try response.mapArray(Repository.self)
                } catch {
                    success = false
                    self.repositories = []
                }
                self.tableView.reloadData()
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                message = error.description
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Table View
    func tableView(_: UITableView, didSelectRowAt: IndexPath) {
        if(searchBar.isFirstResponder) {
            searchBar.resignFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoyaCell", for: indexPath) as UITableViewCell
        
        let repo = repositories[(indexPath as NSIndexPath).row]
        (cell.textLabel as UILabel!).text = repo.name
        return cell
    }
}
