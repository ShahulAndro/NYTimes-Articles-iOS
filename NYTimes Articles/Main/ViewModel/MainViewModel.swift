//
//  MainViewModel.swift
//  NYTimes Articles
//
//  Created by Shahul Hamed Shaik (HLB) on 11/03/2022.
//

import Foundation


class MainViewModel {
    
    //MARK: - Closures for binding the data
    var GetSearchAriclesApiSuccess: ((_ articleSearch: ArticleSearch?)-> ())?
    var GetSearchAriclesApiFail: ((_ error: String?)-> ())?
    var GetMostPopularApiSuccess: ((_ mostPopular: MostPopular?)-> ())?
    var GetMostPopularApiFail: ((_ error: String?)-> ())?
    
    //MARK: - Variable declaration
    var searchType: MainTableSectionDataType?
    var articleSearch: ArticleSearch?
    var mostPopular: MostPopular?
    
    //MARK: - Search Section
    private let searchTypes: [MainTableSectionDataType] = [.SearchArticle]
    
    //MARK: - Popular Section
    private let popularTypes: [MainTableSectionDataType] = [.MostViewed, .MostShared, .MostEmailed]
    
    let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func getMainData() -> [MainPageTable] {
        
        var data = [MainPageTable]()
        
        data.append(MainPageTable(sectionType: .Search, sectionDataTypes: searchTypes)) //Search section
        
        data.append(MainPageTable(sectionType: .Popular, sectionDataTypes: popularTypes))//Popular section
        
        return data
    }
    
    func searchFor(query: String = "") {
        let urlString = "\(Utils.searchURL)\(Utils.aritclesSearch)\(query)&\(Utils.apiKey)"
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    print((data))
                    return
                }
                
                if let error = error {
                    print(error)
                    return
                }
            }
            
            task.resume()
        }
    }
    
    func searchArticles(for query: String = "") {
        apiService.dataRequest(url: getSearchURL(query: query), objectType: ArticleSearch.self) { (result: Result) in
            switch result {
            case .Success(let data):
                self.articleSearch = data
                self.GetSearchAriclesApiSuccess?(data)
            case .Failure(let error, let message):
                print(error)
                self.GetSearchAriclesApiFail?(message)
            }
        }
    }
    
    func getMostPopular(type: MainTableSectionDataType) {
        apiService.dataRequest(url: getMostPopularTypeURL(type: type), objectType: MostPopular.self) { (result: Result) in
            switch result {
            case .Success(let data):
                self.mostPopular = data
                self.GetMostPopularApiSuccess?(data)
            case .Failure(let error, let message):
                print(error)
                self.GetMostPopularApiFail?(message)
            }
        }
    }
    
    func getSearchURL(query: String)-> String {
        let urlString = "\(Utils.searchURL)\(Utils.aritclesSearch)\(query)&\(Utils.apiKey)"
        return urlString
    }
    
    func getMostPopularTypeURL(type: MainTableSectionDataType) -> String {
        if type == .MostViewed {
            return "\(Utils.mostpopularURL)\(Utils.mostViewed)\(Utils.apiKey)"
        } else if type == .MostShared {
            return "\(Utils.mostpopularURL)\(Utils.mostShared)\(Utils.apiKey)"
        } else {
            return "\(Utils.mostpopularURL)\(Utils.mostEmailed)\(Utils.apiKey)"
        }
    }
    
}
