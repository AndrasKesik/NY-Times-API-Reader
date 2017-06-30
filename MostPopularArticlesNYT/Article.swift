//
//  Article.swift
//  MostPopularArticlesNYT
//
//  Created by András Kesik on 2017. 06. 29..
//  Copyright © 2017. Andras Kesik. All rights reserved.
//

import Foundation

class Article {
    var url: String?
    var adx_keywords: String?
    var column: String?
    var section: String?
    var byline: String?
    var type: String?
    var title: String?
    var abstract: String?
    var published_date: String?
    var source: String?
    var id: Int?
    var asset_id: Int?
    var views: Int?
    var des_facet: [String]?
    var org_facet: [String]?
    var per_facet: [String]?
    var geo_facet: [String]?
    
    var media: Media?
    
    init(json: [String: Any]) {
        url = json["url"] as? String
        adx_keywords = json["adx_keywords"] as? String
        column = json["column"] as? String
        section = json["section"] as? String
        byline = json["byline"] as? String
        type = json["type"] as? String
        title = json["title"] as? String
        abstract = json["abstract"] as? String
        published_date = json["published_date"] as? String
        source = json["source"] as? String
        id = json["id"] as? Int
        asset_id = json["asset_id"] as? Int
        views = json["views"] as? Int
        des_facet = json["des_facet"] as? [String]
        org_facet = json["org_facet"] as? [String]
        per_facet = json["per_facet"] as? [String]
        geo_facet = json["geo_facet"] as? [String]
        
        if let mediaDict = (json["media"] as? NSArray)?[0] as? Dictionary<String, Any> {
            media = Media(json: mediaDict)
        }
        
        }
        
}
