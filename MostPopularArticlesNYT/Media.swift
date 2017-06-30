//
//  Media.swift
//  MostPopularArticlesNYT
//
//  Created by András Kesik on 2017. 06. 29..
//  Copyright © 2017. Andras Kesik. All rights reserved.
//

import Foundation

class Media {
    var type: String?
    var subtype: String?
    var caption: String?
    var copyright: String?
    var approved_for_syndication: Int?
    var media_metadata: [MediaMetadata]?
    
    
    init(json: [String:Any]) {
        type = json["type"] as? String
        subtype = json["subtype"] as? String
        caption = json["caption"] as? String
        copyright = json["copyright"] as? String
        approved_for_syndication = json["approved_for_syndication"] as? Int
        
        if let metaDataArray = json["media-metadata"] as? NSArray {
            var data = [MediaMetadata]()
            for metaDataJson in metaDataArray {
                if let metaDataDict = metaDataJson as? Dictionary<String, Any> {
                    data.append(MediaMetadata(json: metaDataDict))
                    
                }
            }
            
            if data.count > 0 {
                media_metadata = data
            }
            
        }
        
        
    }
}
