//
//  SearchArticlesScreen.swift
//  NYTimes ArticlesUITests
//
//  Created by Shahul Hamed Shaik (HLB) on 13/03/2022.
//

import Foundation
import XCTest

class SearchArticlesScreen {
    
    let app: XCUIApplication
    let searchTextField: XCUIElement
    let searchButton: XCUIElement
    
    init(app: XCUIApplication) {
        self.app = app
        self.searchTextField = app.textFields["searchTextField"]
        self.searchButton = app.buttons["searchButton"]
    }
    
    func search(for query: String) {
        searchTextField.tap()
        searchTextField.typeText(query)
    }
    
    func verifySearchQuery(query: String)-> Bool {
        return searchTextField.value as! String == query
    }
    
    func tapSearchButton() {
        searchButton.tap()
    }
    
    func isAllElementsExists()-> Bool {
        return searchTextField.waitForExistence(timeout: 10) && searchButton.exists
    }
}
