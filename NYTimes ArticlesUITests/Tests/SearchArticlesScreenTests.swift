//
//  SearchArticlesScreenTests.swift
//  NYTimes ArticlesUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 13/03/2022.
//

import XCTest

class SearchArticlesScreenTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearchArticlesView() {
        let app = XCUIApplication()
        app.launch()
        
        let mainScreen = MainScreen(app: app)
        XCTAssertTrue(mainScreen.isAllDataExists())
        mainScreen.openSearchAritcles()
        
        let searchArticlesScreen = SearchArticlesScreen(app: app)
        XCTAssertTrue(searchArticlesScreen.isAllElementsExists())
    }
    
    func testSearchArticlesByQuery() {
        let app = XCUIApplication()
        app.launch()
        
        let mainScreen = MainScreen(app: app)
        XCTAssertTrue(mainScreen.isAllDataExists())
        mainScreen.openSearchAritcles()
        
        let searchArticlesScreen = SearchArticlesScreen(app: app)
        XCTAssertTrue(searchArticlesScreen.isAllElementsExists())
        
        searchArticlesScreen.search(for: "World")
        XCTAssertTrue(searchArticlesScreen.verifySearchQuery(query: "World"))
        searchArticlesScreen.tapSearchButton()
        
        let articlesListScreen = ArticlesListScreen(app: app)
        XCTAssertTrue(articlesListScreen.isArticlesScreenExists())
        XCTAssertTrue(articlesListScreen.isArticlesListHaveData())
        
    }
    
}
