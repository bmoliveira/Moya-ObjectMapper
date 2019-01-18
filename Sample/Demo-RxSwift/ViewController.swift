import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxAlertController

class ViewController: UIViewController {
  @IBOutlet weak var zenButton: UIBarButtonItem!
  @IBOutlet weak var searchButton: UIBarButtonItem!
  @IBOutlet var tableView: UITableView!
  
  let retrySearchSubject = PublishSubject<Void>()
  
  let viewModel: RxDemoViewModel = RxDemoViewModel(networking: GitHubProvider)
  
  fileprivate let disposeBag = DisposeBag()
  
  fileprivate var zenAction: Observable<String> {
    return self.zenButton.rx.tap
      .asObservable()
      .flatMap { _ in
        self.viewModel.rx.downloadZen().asObservable()
    }
  }
  
  fileprivate func searchUsername() -> Observable<[Repository]> {
    return UIAlertController.rx.prompt(in: self,
                                       title: "Github username",
                                       message: nil,
                                       defaultValue: "",
                                       closeTitle: "Close",
                                       confirmTitle: "Search")
      .asObservable()
      .flatMap { (username) in
        return self.viewModel.rx.downloadRepositories(username)
          .asObservable()
          .catchError({ (error) -> Observable<[Repository]> in
            self.retrySearchSubject.onNext(())
            return Observable.just([])
          })
    }
  }
  
  fileprivate var retrySearch: Observable<[Repository]> {
    return retrySearchSubject.asObservable()
      .flatMap { self.searchUsername() }
  }
  
  fileprivate var searchUsernameTap: Observable<[Repository]> {
    return searchButton.rx.tap
      .asObservable()
      .flatMap { self.searchUsername() }
  }
  
  fileprivate var defaultSearch: Observable<[Repository]> {
    return viewModel.rx.downloadRepositories("bmoliveira").asObservable()
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initializeViewModel()
  }
  
  fileprivate func initializeViewModel() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    Observable.merge(searchUsernameTap, defaultSearch, retrySearch)
      .bind(to: self.tableView.rx.items(cellIdentifier: "Cell")) { index, model, cell in
        cell.textLabel?.text = model.name
      }
      .disposed(by: disposeBag)
    
    zenAction
      .subscribe { event in
        switch event {
        case .next(let result):
          self.showMessage(message: result)
        case .error(let error):
          self.showError(error: error)
        case .completed:
          break
        }
      }
      .disposed(by: disposeBag)
  }
  
  // MARK: - User Interaction
  @IBAction func searchWasPressed(_ sender: UIBarButtonItem) {
  }
  
  @IBAction func zenWasPressed(_ sender: UIBarButtonItem) {
  }
}

