//
//  APIService.swift
//  NYTimes Articles
//
//  Created by Shahul Hamed Shaik (HLB) on 11/03/2022.
//

import Foundation

enum APIError: Error {
    case NetworkError(Error)
    case DataNotFound(Error)
    case JsonParsingError(Error)
    case InvalidStatusCode(Int)
}

enum Result<T> {
    case Success(T)
    case Failure(APIError, String)
}

protocol APIServiceProtocol {
    func dataRequest<T: Decodable>(url: String, objectType: T.Type, completion: @escaping (Result<T>)-> Void)
}

class APIService: APIServiceProtocol {
    
    func dataRequest<T: Decodable>(url: String, objectType: T.Type, completion: @escaping (Result<T>)-> Void) {
        let dataURL = URL(string: url)!
        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(Result.Failure(APIError.NetworkError(error!), error?.localizedDescription ?? "Generic Error"))
                return
            }
            
            guard let data = data else {
                completion(Result.Failure(APIError.DataNotFound(error!), error?.localizedDescription ?? "Generic Error"))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(Result.Success(decodedObject))
            } catch let error {
                completion(Result.Failure(APIError.JsonParsingError(error as! DecodingError), error.localizedDescription))
            }
        })
        
        task.resume()
    }
    
}
