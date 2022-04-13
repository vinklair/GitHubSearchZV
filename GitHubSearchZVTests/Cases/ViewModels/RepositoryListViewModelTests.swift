//
//  SearchRepositoryTests.swift
//  GitHubSearchZVTests
//
//  Created by Zoltan Vinkler on 2022. 04. 13..
//

import XCTest
import Alamofire
import Mocker
@testable import GitHubSearchZV

class RepositoryListViewModelTests: XCTestCase, DecodableTestCase {
    var dictionary: JsonObject!
    var sut: RepositoryResponse!
    var sessionMocked: Session!
    var apiEndpoint: URL!
    var mockedData: Data!
    var viewModel: RepositoryListViewModel!
    
    override func setUp() {
        super.setUp()

        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        sessionMocked = Session(configuration: configuration)
        apiEndpoint = URL(string: GitHubAPI.searchURL(q: "Kingfisher")!)!
        mockedData = try! Data.fromJSON(fileName: "RepositoryResponse")
        viewModel = RepositoryListViewModel()

        try? givenSUTFromJSON(fileName: "RepositoryResponse")
    }

    override func tearDown() {
        dictionary = nil
        sut = nil
        sessionMocked = nil
        apiEndpoint = nil
        mockedData = nil
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Mocking Alamofire requests with Mocker
    
    func test_repositoryListViewModel_searchRepositorySuccess() {
        let requestExpectation = expectation(description: "Request should success")
        Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData]).register()
        
        viewModel.loadingState.bind { [weak self] loadingState in
            switch loadingState {
            case .success:
                // Compare response data with mocked data
                if let sutRepositories = self?.sut.items.map(RepositoryViewModel.init),
                    self?.viewModel.repositories.value == sutRepositories {
                    requestExpectation.fulfill()
                }
            case .failure(let errorDescription):
                XCTFail(errorDescription)
            default:
                break
            }
        }

        viewModel.session = sessionMocked
        viewModel.searchRepository(text: "Kingfisher")
        
        wait(for: [requestExpectation], timeout: 2.0)
    }
    
    func test_repositoryListViewModel_searchRepositoryFailure() {
        let requestExpectation = expectation(description: "Request should fail")
        Mock(url: apiEndpoint, dataType: .json, statusCode: 400, data: [.get: mockedData]).register()
        
        viewModel.loadingState.bind { loadingState in
            switch loadingState {
            case .failure:
                requestExpectation.fulfill()
            default:
                break
            }
        }

        viewModel.session = sessionMocked
        viewModel.searchRepository(text: "Kingfisher")
        
        wait(for: [requestExpectation], timeout: 2.0)
    }
    
}
