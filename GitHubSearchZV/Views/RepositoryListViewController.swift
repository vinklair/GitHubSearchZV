//
//  RepoListViewController.swift
//  GitHubSearchZV
//
//  Created by Zoltan Vinkler on 2022. 04. 11..
//

import UIKit
import SafariServices

class RepositoryListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIStackView!
    
    var repositoryListViewModel = RepositoryListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        indicatorView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bindViewModel()
    }
    
    func bindViewModel() {
        // Show/hide loading indicator and show alert in case of an error
        repositoryListViewModel.loadingState.bind { [weak self] loadingState in
            guard let self = self else { return }
            switch loadingState {
            case .loading:
                self.indicatorView.isHidden = false
            case .failure(let errorDescription):
                Alert.show(on: self, title: errorDescription)
                fallthrough
            default:
                self.indicatorView.isHidden = true
            }
        }
        // Reload table view if data has changed
        repositoryListViewModel.repositories.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    func searchRepository(text: String) {
        repositoryListViewModel.searchRepository(text: text)
    }
    
}

// MARK: - UISearchBarDelegate

extension RepositoryListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        searchBar.resignFirstResponder()
        searchRepository(text: searchText)
    }
    
}

// MARK: - UITableViewDataSource

extension RepositoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositoryListViewModel.repositories.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryCell
        let repositoryViewModel = repositoryListViewModel.repositories.value[indexPath.row]
        cell.configureCell(with: repositoryViewModel)
        return cell
    }
        
}

// MARK: - UITableViewDelegate

extension RepositoryListViewController: UITableViewDelegate {
    
    // Load web page inside application
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let repositoryViewModel = repositoryListViewModel.repositories.value[indexPath.row]
        guard let htmlUrl = repositoryViewModel.htmlUrl else {
            return
        }
        let safariVC = SFSafariViewController(url: htmlUrl)
        present(safariVC, animated: true)
    }
    
}
