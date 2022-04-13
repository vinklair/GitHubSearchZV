//
//  GitHubAPI.swift
//  GitHubSearchZV
//
//  Created by Zoltan Vinkler on 2022. 04. 12..
//

struct GitHubAPI {
    static let baseURL = "https://api.github.com/search/repositories"
    
    static func searchURL(q: String) -> String? {
        "\(baseURL)?q=\(q)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
