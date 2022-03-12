//
//  MainViewUITests.swift
//  NYTimes ArticlesUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 13/03/2022.
//

import XCTest

class MainViewUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMainView() {
        let app = XCUIApplication()
        app.launch()
        
        let mainScreen = MainScreen(app: app)
        
        XCTAssertTrue(mainScreen.isAllDataExists())
    }
    
    func testSearchAricles() {
        let app = XCUIApplication()
        app.launch()
        
        let mainScreen = MainScreen(app: app)
        mainScreen.openSearchAritcles()
        
        let searchArticlesScreen = SearchArticlesScreen(app: app)
        
        XCTAssertTrue(searchArticlesScreen.isAllElementsExists())
    }
    
    func testMostViewedArticles() {
        let app = XCUIApplication()
        app.launch()
        
        let mainScreen = MainScreen(app: app)
        mainScreen.openMostViewed()
        
        let articlesScreen = ArticlesListScreen(app: app)
        
        XCTAssertTrue(articlesScreen.isArticlesScreenExists())
    }
    
    func testMostSharedArticles() {
        let app = XCUIApplication()
        app.launch()
        
        let mainScreen = MainScreen(app: app)
        mainScreen.openMostShared()
        
        let articlesScreen = ArticlesListScreen(app: app)
        
        XCTAssertTrue(articlesScreen.isArticlesScreenExists())
    }
    
    func testMostEmailedArticles() {
        let app = XCUIApplication()
        app.launch()
        
        let mainScreen = MainScreen(app: app)
        mainScreen.openMostEmailed()
        
        let articlesScreen = ArticlesListScreen(app: app)
        
        XCTAssertTrue(articlesScreen.isArticlesScreenExists())
    }

}
