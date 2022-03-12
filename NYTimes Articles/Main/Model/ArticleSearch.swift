//
//  ArticleSearch.swift
//  NYTimes Articles
//
//  Created by Shahul Hamed Shaik (HLB) on 11/03/2022.
//

import Foundation

struct ArticleSearch: Decodable {
    var status: String?
    var copyright: String?
    var response: Document?
}

struct Document: Decodable {
    var docs: [AritcleDoc]?
}

struct AritcleDoc: Decodable {
    var abstract: String?
    var web_url: String?
    var snippet: String?
    var lead_paragraph: String?
    var source: String?
    var pub_date: String?
    var document_type: String?
    var news_desk: String?
    var headline: Headline?
}

struct Headline: Decodable {
    var main: String?
    var print_headline: String?
}
