//
//  ArticlesListScreenTests.swift
//  NYTimes ArticlesUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 13/03/2022.
//

import XCTest

class ArticlesListScreenTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMostViewedArticlesList() {
        let app = XCUIApplication()
        app.launch()
        
        let mainScreen = MainScreen(app: app)
        XCTAssertTrue(mainScreen.isAllDataExists())
        mainScreen.openMostViewed()
        
        let articlesListScreen = ArticlesListScreen(app: app)
        XCTAssertTrue(articlesListScreen.isArticlesScreenExists())
        XCTAssertTrue(articlesListScreen.isArticlesListHaveData())
    }
    
    func testMostSharedArticlesList() {
        let app = XCUIApplication()
        app.launch()
        
        let mainScreen = MainScreen(app: app)
        XCTAssertTrue(mainScreen.isAllDataExists())
        mainScreen.openMostShared()
        
        let articlesListScreen = ArticlesListScreen(app: app)
        XCTAssertTrue(articlesListScreen.isArticlesScreenExists())
        XCTAssertTrue(articlesListScreen.isArticlesListHaveData())
    }
    
    func testMostEmailedArticlesList() {
        let app = XCUIApplication()
        app.launch()
        
        let mainScreen = MainScreen(app: app)
        XCTAssertTrue(mainScreen.isAllDataExists())
        mainScreen.openMostEmailed()
        
        let articlesListScreen = ArticlesListScreen(app: app)
        XCTAssertTrue(articlesListScreen.isArticlesScreenExists())
        XCTAssertTrue(articlesListScreen.isArticlesListHaveData())
    }

}
