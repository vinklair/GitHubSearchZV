//
//  LoadingState.swift
//  GitHubSearchZV
//
//  Created by Zoltan Vinkler on 2022. 04. 12..
//

enum LoadingState {
    case loading
    case failure(String)
    case success
}

protocol LoadingStateProtocol {
    var loadingState: Dynamic<LoadingState?> { get }
}
