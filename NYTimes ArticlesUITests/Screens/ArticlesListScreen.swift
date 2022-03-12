//
//  ArticlesListScreen.swift
//  NYTimes ArticlesUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 13/03/2022.
//

import Foundation
import XCTest

class ArticlesListScreen {
    
    let app: XCUIApplication
    let articleTableView: XCUIElement
    
    init(app: XCUIApplication) {
        self.app = app
        articleTableView = app.tables["articleTableView"]
    }
    
    func isArticlesListHaveData()-> Bool {
        return articleTableView.cells.count > 0
    }
    
    func isArticlesScreenExists()-> Bool {
        return app.navigationBars.staticTexts["Articles"].waitForExistence(timeout: 15)
    }
}
