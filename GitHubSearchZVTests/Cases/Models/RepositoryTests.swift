//
//  RepositoryTests.swift
//  GitHubSearchZVTests
//
//  Created by Zoltan Vinkler on 2022. 04. 13..
//

import XCTest
@testable import GitHubSearchZV

class RepositoryTests: XCTestCase, DecodableTestCase {
    var dictionary: JsonObject!
    var sut: RepositoryResponse!
    var itemsFirst: JsonObject?
    
    override func setUp() {
        super.setUp()
        try? givenSUTFromJSON()
        itemsFirst = try? XCTUnwrap((dictionary["items"] as? [JsonObject])?.first)
    }

    override func tearDown() {
        dictionary = nil
        sut = nil
        super.tearDown()
    }
    
    func test_conformsTo_Decodable() {
        XCTAssertTrue((sut as Any) is Decodable)
    }
    
    func test_decodable_itemsFirstId() {
        XCTAssertEqual(sut.items.first?.id, itemsFirst?["id"] as? Int)
    }
    
    func test_decodable_itemsFirstName() {
        XCTAssertEqual(sut.items.first?.name, itemsFirst?["name"] as? String)
    }
    
    func test_decodable_itemsFirstOwnerLogin() {
        XCTAssertEqual(sut.items.first?.owner.login, (itemsFirst?["owner"] as? JsonObject)?["login"] as? String)
    }
    
    func test_decodable_itemsFirstOwnerAvatarUrl() {
        XCTAssertEqual(sut.items.first?.owner.avatarUrl, (itemsFirst?["owner"] as? JsonObject)?["avatar_url"] as? String)
    }
    
    func test_decodable_itemsFirstHtmlUrl() {
        XCTAssertEqual(sut.items.first?.htmlUrl, itemsFirst?["html_url"] as? String)
    }
    
    func test_decodable_itemsFirstDescription() {
        XCTAssertEqual(sut.items.first?.description, itemsFirst?["description"] as? String)
    }
    
    func test_decodable_itemsFirstStars() {
        XCTAssertEqual(sut.items.first?.stars, itemsFirst?["stargazers_count"] as? Int)
    }
    
    func test_decodable_itemsFirstLanguage() {
        XCTAssertEqual(sut.items.first?.language, itemsFirst?["language"] as? String)
    }
    
}
