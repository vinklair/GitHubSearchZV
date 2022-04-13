//
//  RepositoryListViewModel.swift
//  GitHubSearchZV
//
//  Created by Zoltan Vinkler on 2022. 04. 12..
//

import Alamofire

// GitHub repositories list
class RepositoryListViewModel: LoadingStateProtocol {
    var session = Session()
    
    let loadingState: Dynamic<LoadingState?> = Dynamic(nil)
    let repositories = Dynamic<[RepositoryViewModel]>([])
    
    func searchRepository(text: String) {
        guard let searchUrl = GitHubAPI.searchURL(q: text) else {
            return
        }
        loadingState.value = .loading
        session.request(searchUrl).validate().responseDecodable(of: RepositoryResponse.self) { [weak self] response in
            switch response.result {
            case .success(let repositoryResponse):
                self?.repositories.value = repositoryResponse.items.map(RepositoryViewModel.init)
                self?.loadingState.value = .success
            case .failure(let error):
                self?.loadingState.value = .failure(error.localizedDescription)
                debugPrint(error)
            }
        }
    }
}
