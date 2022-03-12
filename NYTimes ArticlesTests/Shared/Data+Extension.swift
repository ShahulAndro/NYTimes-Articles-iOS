//
//  Data+Extension.swift
//  NYTimes ArticlesTests
//
//  Created by Shahul Hamed Shaik (HLB) on 12/03/2022.
//

import Foundation
import XCTest

extension Data {
    
    public static func fromJSON(fileName: String, withExtension: String = "json") throws -> Data {
        let bundle = Bundle(for: TestBundleClass.self)
        let url = try XCTUnwrap(bundle.url(forResource: fileName, withExtension: withExtension))
        return try Data(contentsOf: url)
    }
    
}

private class TestBundleClass { }
