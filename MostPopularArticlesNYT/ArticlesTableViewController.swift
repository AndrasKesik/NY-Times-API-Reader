//
//  MasterViewController.swift
//  MostPopularArticlesNYT
//
//  Created by András Kesik on 2017. 06. 29..
//  Copyright © 2017. Andras Kesik. All rights reserved.
//

import UIKit

enum ResultsPeriod: String {
    case oneDay = "1"
    case sevenDays = "7"
    case thirtyDays = "30"
}

struct NYTApiRequestElements {
    let baseURL: String = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed"
    let section: String
    let period: String
    let api_key: String = ""  // Insert your API key here between the quotation marks
    let completeURL: URL?
    
    init(section: String, period: ResultsPeriod) {
        self.section = section
        self.period = period.rawValue
        
        completeURL = URL(string: "\(baseURL)/\(self.section)/\(self.period).json?api-key=\(self.api_key)")
    }
}


class ArticlesTableViewViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    
    var articles = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed(_:)))
        navigationItem.rightBarButtonItem = searchButton
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        let allSectionsForSevendays = NYTApiRequestElements(section: "all-sections", period: .sevenDays)
        
        fetchArticles(urlString: allSectionsForSevendays.completeURL)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    func searchButtonPressed(_ sender: Any) {
        
    }
    
    // MARK: - Utilities
    
    func fetchArticles(urlString: URL?) {
        guard let url = urlString else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                if let results = json["results"] as? NSArray {
                    for jsonArticle in results {
                        if let articleDict = jsonArticle as? Dictionary<String, Any>{
                            self.articles.append(Article(json: articleDict) )
                        }
                    }
                }
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
        
    }

    func loadImage(urlString: String,to imageView:UIImageView) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                imageView.image = UIImage(data: data)
            }
        }.resume()

    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ArticleTableViewCell", owner: self, options: nil)?.first as! ArticleTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        let article = articles[indexPath.row] as Article
        
        if let title = article.title {
            cell.titleLabel.text = title
        }
        if let byline = article.byline {
            cell.authorLabel.text = byline
        }
        if let dateString = article.published_date {
             cell.dateLabel.text = dateString
        }
        
        let metaDataArray = article.media?.media_metadata
        if let imageIndex = metaDataArray?.index(where: {$0.format == "Standard Thumbnail"}),
            let imageUrlString = metaDataArray?[imageIndex].url {
            
            loadImage(urlString: imageUrlString, to: cell.articlePicture)
            cell.articlePicture.layer.cornerRadius = cell.articlePicture.frame.size.width/2
            cell.articlePicture.clipsToBounds = true
        }
     
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
        
//   Uncomment this (and delete the performSeque) for opening the real details in safari
/*        if let url = URL(string:articles[indexPath.row].url!) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
*/
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let article = articles[indexPath.row] as Article
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = article
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

