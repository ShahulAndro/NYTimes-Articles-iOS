//
//  MockAPIService.swift
//  NYTimes ArticlesTests
//
//  Created by Shahul Hamed Shaik (HLB) on 12/03/2022.
//

import Foundation

class MockAPIService: APIServiceProtocol {
    
    var type: MainTableSectionDataType?
    
    var completion: ((Result<Any>)-> ()-> ())?
    
    func dataRequest<T>(url: String, objectType: T.Type, completion: @escaping (Result<T>)-> Void) where T: Decodable {
        do {
            let data = try Data.fromJSON(fileName: getFileName())
            let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
            completion(Result.Success(decodedObject))
        } catch let error {
            completion(Result.Failure(APIError.JsonParsingError(error as! DecodingError), error.localizedDescription))
        }
    }
    
    func getFileName()-> String {
        if type == .SearchArticle {
            return "articlesearch"
        } else if type == .MostViewed {
            return "mostviewed"
        } else if type == .MostShared {
            return "mostshared"
        } else {
            return "mostemailed"
        }
    }
    
}
