//
//  RepositoryViewModel.swift
//  GitHubSearchZV
//
//  Created by Zoltan Vinkler on 2022. 04. 12..
//

import Foundation

class RepositoryViewModel: Equatable {
    let repositoryModel: RepositoryItem
    
    static func == (lhs: RepositoryViewModel, rhs: RepositoryViewModel) -> Bool {
        lhs.repositoryModel == rhs.repositoryModel
    }
    
    init(repositoryModel: RepositoryItem) {
        self.repositoryModel = repositoryModel
    }
    
    var repositoryName: String {
        repositoryModel.name
    }
    
    var ownerName: String {
        "Owner: \(repositoryModel.owner.login)"
    }
    
    var ownerAvatarUrl: URL? {
        URL(string: repositoryModel.owner.avatarUrl ?? "")
    }
    
    var htmlUrl: URL? {
        URL(string: repositoryModel.htmlUrl ?? "")
    }
    
    var description: String {
        repositoryModel.description ?? ""
    }
    
    var stars: String {
        "\(repositoryModel.stars ?? 0)"
    }
    
    var language: String {
        repositoryModel.language ?? ""
    }
    
}
