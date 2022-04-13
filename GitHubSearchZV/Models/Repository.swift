//
//  Repository.swift
//  GitHubSearchZV
//
//  Created by Zoltan Vinkler on 2022. 04. 11..
//

struct RepositoryResponse: Decodable, Equatable {
    let items: [RepositoryItem]
}

struct RepositoryItem: Decodable, Equatable {
    let id: Int
    let name: String
    let owner: RepositoryOwner
    let htmlUrl: String?
    let description: String?
    let stars: Int?
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, owner
        case htmlUrl = "html_url"
        case description
        case stars = "stargazers_count"
        case language
    }
}

struct RepositoryOwner: Decodable, Equatable {
    let login: String
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
