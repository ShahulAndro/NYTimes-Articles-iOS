//
//  MainScreen.swift
//  NYTimes ArticlesUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 13/03/2022.
//

import Foundation
import XCTest

class MainScreen {
    
    let app: XCUIApplication
    let mainTableView: XCUIElement
    
    init(app: XCUIApplication) {
        self.app = app
        mainTableView = app.tables["mainTableView"]
    }
    
    func openSearchAritcles() {
        mainTableView.staticTexts["Search Articles"].tap()
    }
    
    func openMostViewed() {
        mainTableView.staticTexts["Most Viewed"].tap()
    }
    
    func openMostShared() {
        mainTableView.staticTexts["Most Shared"].tap()
    }
    
    func openMostEmailed() {
        mainTableView.staticTexts["Most Emailed"].tap()
    }
    
    func isAllDataExists()-> Bool {
        return mainTableView.staticTexts["Search"].waitForExistence(timeout: 15) &&
        mainTableView.staticTexts["Search Articles"].exists &&
        mainTableView.staticTexts["Popular"].exists &&
        mainTableView.staticTexts["Most Viewed"].exists &&
        mainTableView.staticTexts["Most Shared"].exists &&
        mainTableView.staticTexts["Most Emailed"].exists
    }
}

