//
//  DetailViewController.swift
//  MostPopularArticlesNYT
//
//  Created by András Kesik on 2017. 06. 29..
//  Copyright © 2017. Andras Kesik. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let article = detailItem {
            if let title = titleLabel {
                title.text = article.title
            }
            if let byline = bylineLabel {
                byline.text = article.byline
            }
            if let abstract = abstractLabel {
                abstract.text = article.abstract
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Article? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

