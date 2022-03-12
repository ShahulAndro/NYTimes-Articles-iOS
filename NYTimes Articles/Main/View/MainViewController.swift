//
//  MainViewController.swift
//  NYTimes Articles
//
//  Created by Shahul Hamed Shaik (HLB) on 11/03/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var copyrightingLabel: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel =  MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.accessibilityIdentifier = "mainTableView"
        activityIndicator.isHidden = true
        
        self.mainTableView.register(UINib(nibName: "MainSectionTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "MainSectionTableViewCell")
        self.mainTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")

        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        self.mainTableView.reloadData()
        
        manageViewModelBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mainTableView.deselectAlreadySelectedRow(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let articlesListVC = segue.destination as? ArticlesListViewController, let mostPopular = sender as? MostPopular {
            articlesListVC.mostPopular = mostPopular
            return
        }
        
        if let searchViewVC = segue.destination as? SearchViewController, let searchType = sender as? MainTableSectionDataType {
            searchViewVC.viewModel.searchType = searchType
            return
        }
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.getMainData().count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = self.mainTableView.dequeueReusableHeaderFooterView(withIdentifier: "MainSectionTableViewCell") as! MainSectionTableViewCell
        let mainData = self.viewModel.getMainData()[section]
        header.updateSection(title: mainData.sectionType?.rawValue ?? "")
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mainData = self.viewModel.getMainData()[section]
        return mainData.sectionDataTypes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        let mainData = self.viewModel.getMainData()[indexPath.section]
        if let description = mainData.sectionDataTypes?[indexPath.row] {
            cell.updateCell(title: description.rawValue)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainData = self.viewModel.getMainData()[indexPath.section]
        
        if let selectionType = mainData.sectionDataTypes?[indexPath.row] {
            if  selectionType == .SearchArticle {
                self.performSegue(withIdentifier: "search", sender: selectionType)
            } else if selectionType == .MostViewed || selectionType == .MostShared || selectionType == .MostEmailed {
                showLoadingIndicator()
                viewModel.getMostPopular(type: selectionType)
            }
            
        }
        
    }
    
}

//MARK: - ViewModel bindings

extension MainViewController {
    
    func manageViewModelBindings() {
        viewModel.GetMostPopularApiSuccess = { [weak self] (data) in
            DispatchQueue.main.async {
                self?.hideLoadingIndicator()
                self?.performSegue(withIdentifier: "articlesFromMain", sender: data)
            }
        }
        
        viewModel.GetMostPopularApiFail = { [weak self] (errorMessage) in
            self?.hideLoadingIndicator()
            guard let self = self else { return }
            Utils.showAlert(vc: self, message: errorMessage ?? "Generic Error")
        }
    }
}

//MARK: - Helper methods

extension MainViewController {
    
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

