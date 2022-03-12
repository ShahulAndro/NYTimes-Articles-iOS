//
//  MostPopular.swift
//  NYTimes Articles
//
//  Created by Shahul Hamed Shaik (HLB) on 11/03/2022.
//

import Foundation

struct MostPopular: Decodable {
    var status: String?
    var copyright: String?
    var num_results: Int?
    var results: [PopularResult]?
}

struct PopularResult: Decodable {
    var uri: String?
    var url: String?
    var source: String?
    var published_date: String?
    var updated: String?
    var section: String?
    var title: String?
    var abstract: String?
    
}
