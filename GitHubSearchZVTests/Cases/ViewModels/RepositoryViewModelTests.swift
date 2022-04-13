//
//  RepositoryViewModelTests.swift
//  GitHubSearchZVTests
//
//  Created by Zoltan Vinkler on 2022. 04. 13..
//

import XCTest
@testable import GitHubSearchZV

class RepositoryViewModelTests: XCTestCase {
    var sut: RepositoryViewModel!
    var repositoryItem: RepositoryItem!
    
    override func setUp() {
        super.setUp()
        repositoryItem = RepositoryItem(
            id: 33486016,
            name: "Kingfisher",
            owner: RepositoryOwner(
                login: "onevcat",
                avatarUrl: "https://avatars.githubusercontent.com/u/1019875?v=4"
            ),
            htmlUrl: "https://github.com/onevcat/Kingfisher",
            description: "A lightweight, pure-Swift library for downloading and caching images from the web.",
            stars: 19978,
            language: "Swift"
        )
        sut = RepositoryViewModel(repositoryModel: repositoryItem)
    }
    
    override func tearDown() {
        sut = nil
        repositoryItem = nil
        super.tearDown()
    }
    
    func test_repositoryViewModel_setsRepositoryModel() {
        XCTAssertEqual(sut.repositoryModel, repositoryItem)
    }
    
    func test_repositoryViewModel_setsRepositoryName() {
        XCTAssertEqual(sut.repositoryName, repositoryItem.name)
    }
    
    func test_repositoryViewModel_setsOwnerName() {
        XCTAssertEqual(sut.ownerName, "Owner: \(repositoryItem.owner.login)")
    }
    
    func test_repositoryViewModel_setsOwnerAvatarUrl() {
        XCTAssertEqual(sut.ownerAvatarUrl, URL(string: repositoryItem.owner.avatarUrl ?? ""))
    }
    
    func test_repositoryViewModel_setsHtmlUrl() {
        XCTAssertEqual(sut.htmlUrl, URL(string: repositoryItem.htmlUrl ?? ""))
    }
    
    func test_repositoryViewModel_setsDescription() {
        XCTAssertEqual(sut.description, repositoryItem.description ?? "")
    }
    
    func test_repositoryViewModel_setsStars() {
        XCTAssertEqual(sut.stars, "\(repositoryItem.stars ?? 0)")
    }
    
    func test_repositoryViewModel_setsLanguage() {
        XCTAssertEqual(sut.language, repositoryItem.language ?? "")
    }
    
}
