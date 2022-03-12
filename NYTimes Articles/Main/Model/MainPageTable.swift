//
//  MainPageTable.swift
//  NYTimes Articles
//
//  Created by Shahul Hamed Shaik (HLB) on 11/03/2022.
//

import Foundation

struct MainPageTable {
    var sectionType: MainTableSectionType?
    var sectionDataTypes: [MainTableSectionDataType]?
}

enum MainTableSectionType: String {
    case Search
    case Popular
}

enum MainTableSectionDataType: String {
    case SearchArticle = "Search Articles"
    case MostViewed = "Most Viewed"
    case MostShared = "Most Shared"
    case MostEmailed = "Most Emailed"
}
