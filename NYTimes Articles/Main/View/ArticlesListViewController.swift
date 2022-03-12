//
//  ArticlesListViewController.swift
//  NYTimes Articles
//
//  Created by Shahul Hamed Shaik (HLB) on 11/03/2022.
//

import UIKit

class ArticlesListViewController: UIViewController {

    @IBOutlet weak var articleTableView: UITableView!
    
    var articles: ArticleSearch?
    var mostPopular: MostPopular?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTableView.accessibilityIdentifier = "articleTableView"
        
        self.articleTableView.register(UINib(nibName: "AritcleTableViewCell", bundle: nil), forCellReuseIdentifier: "AritcleTableViewCell")
        self.articleTableView.delegate = self
        self.articleTableView.dataSource = self
        
        loadTableView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension ArticlesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let docs = articles?.response?.docs {
            return docs.count
        }
        
        if let results = mostPopular?.results {
            return results.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AritcleTableViewCell", for: indexPath) as! AritcleTableViewCell
        
        let (title, publishedDate) = getAritcleData(row: indexPath.row)
        cell.updateCell(title: title, pDate: publishedDate)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

//MARK: - Helper methods

extension ArticlesListViewController {
    
    func loadTableView() {
        if let _ = articles {
            self.articleTableView.reloadData()
            return
        }
        
        if let _ = mostPopular {
            self.articleTableView.reloadData()
            return
        }
    }
    
    func getAritcleData(row: Int) -> (String?, String?) {
        
        if let docs = articles?.response?.docs {
            let doc = docs[row]
            return (doc.headline?.main ?? "", doc.pub_date)
        }
        
        if let results = mostPopular?.results {
            let result = results[row]
            return (result.title, result.published_date)
        }
        
        return ("", "")
        
    }
}
