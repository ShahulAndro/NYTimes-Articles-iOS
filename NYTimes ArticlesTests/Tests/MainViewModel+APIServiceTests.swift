//
//  MainViewModel+APIServiceTests.swift
//  NYTimes ArticlesTests
//
//  Created by Shahul Hamed Shaik (HLB) on 12/03/2022.
//

import XCTest

class MainViewModelTests: XCTestCase {
    
    var apiService: MockAPIService!
    var viewModel: MainViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.apiService = MockAPIService()
        self.viewModel = MainViewModel(apiService: self.apiService)
    }
    
    override func tearDown() {
        self.apiService = nil
        self.viewModel = nil
        super.tearDown()
    }
    
    func testSearchAritclesSuccess() {
        viewModel.GetSearchAriclesApiSuccess = {  data in
            XCTAssertNotNil(data)
        }
        
        viewModel.searchArticles()
    }
    
    func testgetMostPopularViewed() {
        viewModel.GetMostPopularApiSuccess = {  data in
            XCTAssertNotNil(data)
        }
        
        viewModel.getMostPopular(type: .MostViewed)
    }
    
    func testgetMostPopularShared() {
        viewModel.GetMostPopularApiSuccess = {  data in
            XCTAssertNotNil(data)
        }
        
        viewModel.getMostPopular(type: .MostShared)
    }
    
    func testgetMostPopularEmailed() {
        viewModel.GetMostPopularApiSuccess = {  data in
            XCTAssertNotNil(data)
        }
        
        viewModel.getMostPopular(type: .MostEmailed)
    }
    
    func testSearchArticlesAPIServiceSuccess() {
        let query = "election"
        let url = viewModel.getSearchURL(query: query)
        
        self.apiService.dataRequest(url: url, objectType: ArticleSearch.self) { (result: Result) in
            switch result {
            case .Success(let data):
                XCTAssertNotNil(data)
            case .Failure(let error, let message):
                XCTAssertNil(error)
                XCTAssertNil(message)
            }
        }
    }
    
    func testGetMostPopularViewedAPIServiceSuccess() {
        let type = MainTableSectionDataType.MostViewed
        let url = viewModel.getMostPopularTypeURL(type: type)
        
        self.apiService.dataRequest(url: url, objectType: MostPopular.self) { (result: Result) in
            switch result {
            case .Success(let data):
                XCTAssertNotNil(data)
            case .Failure(let error, let message):
                XCTAssertNil(error)
                XCTAssertNil(message)
            }
        }
    }
    
    func testGetMostPopularSharedAPIServiceSuccess() {
        let type = MainTableSectionDataType.MostShared
        let url = viewModel.getMostPopularTypeURL(type: type)
        
        self.apiService.dataRequest(url: url, objectType: MostPopular.self) { (result: Result) in
            switch result {
            case .Success(let data):
                XCTAssertNotNil(data)
            case .Failure(let error, let message):
                XCTAssertNil(error)
                XCTAssertNil(message)
            }
        }
    }
    
    func testGetMostPopularEmailedAPIServiceSuccess() {
        let type = MainTableSectionDataType.MostEmailed
        let url = viewModel.getMostPopularTypeURL(type: type)
        
        self.apiService.dataRequest(url: url, objectType: MostPopular.self) { (result: Result) in
            switch result {
            case .Success(let data):
                XCTAssertNotNil(data)
            case .Failure(let error, let message):
                XCTAssertNil(error)
                XCTAssertNil(message)
            }
        }
    }
    
    func testMainData() {
        let mainData = viewModel.getMainData()
        
        XCTAssertTrue(!mainData.isEmpty)
        XCTAssertNotNil(mainData.filter{ $0.sectionType == .Search})
        XCTAssertNotNil(mainData.filter{ $0.sectionType == .Search}.first?.sectionDataTypes)
        XCTAssertNotNil(mainData.filter{ $0.sectionType == .Popular})
        XCTAssertNotNil(mainData.filter{ $0.sectionType == .Popular}.first?.sectionDataTypes)
    }
    
    func testSearchArticlesURLWithEmptyQuery() {
        let expectedURL = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=&api-key=uGWjxAAPkjuXmKjGHsUOyFezqbXZtpIn"
        
        //Given
        let searchQuery = ""
        
        //When
        let actualURL = viewModel.getSearchURL(query: searchQuery)
        
        //Assert
        XCTAssertEqual(expectedURL, actualURL)
    }
    
    func testSearchArticlesURL() {
        let expectedURL = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=World&api-key=uGWjxAAPkjuXmKjGHsUOyFezqbXZtpIn"
        
        //Given
        let searchQuery = "World"
        
        //When
        let actualURL = viewModel.getSearchURL(query: searchQuery)
        
        //Assert
        XCTAssertEqual(expectedURL, actualURL)
    }
    
    func testMostViewedURL() {
        let expectedURL = "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=uGWjxAAPkjuXmKjGHsUOyFezqbXZtpIn"
        
        //Given
        let type = MainTableSectionDataType.MostViewed
        
        //When
        let actualURL = viewModel.getMostPopularTypeURL(type: type)
        
        //Assert
        XCTAssertEqual(expectedURL, actualURL)
    }
    
    func testMostSharedURL() {
        let expectedURL = "https://api.nytimes.com/svc/mostpopular/v2/shared/1/facebook.json?api-key=uGWjxAAPkjuXmKjGHsUOyFezqbXZtpIn"
        
        //Given
        let type = MainTableSectionDataType.MostShared
        
        //When
        let actualURL = viewModel.getMostPopularTypeURL(type: type)
        
        //Assert
        XCTAssertEqual(expectedURL, actualURL)
    }
    
    func testMostEmailedURL() {
        let expectedURL = "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=uGWjxAAPkjuXmKjGHsUOyFezqbXZtpIn"
        
        //Given
        let type = MainTableSectionDataType.MostEmailed
        
        //When
        let actualURL = viewModel.getMostPopularTypeURL(type: type)
        
        //Assert
        XCTAssertEqual(expectedURL, actualURL)
    }

}
