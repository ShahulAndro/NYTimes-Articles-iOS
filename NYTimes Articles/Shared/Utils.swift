//
//  Utils.swift
//  NYTimes Articles
//
//  Created by Shahul Hamed Shaik (HLB) on 11/03/2022.
//

import Foundation
import UIKit

class Utils {
    static var viewedPeriod = 1
    static var sharedPeriod = 1
    static var emailedPeriod = 7
    static var shareType = "facebook"
    
    static let searchURL = "https://api.nytimes.com/svc/search/v2/"
    static let mostpopularURL = "https://api.nytimes.com/svc/mostpopular/v2/"
    static let apiKey = "api-key=uGWjxAAPkjuXmKjGHsUOyFezqbXZtpIn"
    
    static let aritclesSearch = "articlesearch.json?q="
    static let mostViewed = "viewed/\(viewedPeriod).json?"
    static let mostShared = "shared/\(sharedPeriod)/\(shareType).json?"
    static let mostEmailed = "emailed/\(emailedPeriod).json?"
    
    static func showAlert(vc: UIViewController, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
