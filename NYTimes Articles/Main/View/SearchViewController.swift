//
//  SearchViewController.swift
//  NYTimes Articles
//
//  Created by Shahul Hamed Shaik (HLB) on 11/03/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    lazy var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.accessibilityIdentifier = "searchTextField"
        searchButton.accessibilityIdentifier = "searchButton"
        
        activityIndicator.isHidden = true
        if let searchTypeValue = viewModel.searchType?.rawValue {
            searchTextField.placeholder = "\(searchTypeValue) here..."
        }
        
        manageViewModelBindings()
    }
    
    @IBAction func tapOnSearch(_ sender: Any) {
        showLoadingIndicator()
        searchTextField.resignFirstResponder()
        viewModel.searchArticles(for: searchTextField.text ?? "")
    }
    
    
//     MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let articlesListVC = segue.destination as? ArticlesListViewController, let articles = viewModel.articleSearch {
            articlesListVC.articles = articles
        }
        
    }

}

//MARK: - Helper methods

extension SearchViewController {
    
    private func manageViewModelBindings() {
        viewModel.GetSearchAriclesApiSuccess = { [weak self] (data) in
            DispatchQueue.main.async {
                self?.hideLoadingIndicator()
                self?.performSegue(withIdentifier: "aritclesFromSearch", sender: nil)
            }
        }
        
        viewModel.GetSearchAriclesApiFail = { [weak self] (errorMessage) in
            self?.hideLoadingIndicator()
            guard let self = self else { return }
            Utils.showAlert(vc: self, message: errorMessage ?? "Generic Error")
        }
    }
    
    private func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
}
