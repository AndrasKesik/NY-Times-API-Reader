//
//  MediaMetadata.swift
//  MostPopularArticlesNYT
//
//  Created by András Kesik on 2017. 06. 29..
//  Copyright © 2017. Andras Kesik. All rights reserved.
//

import Foundation

class MediaMetadata {
    var url: String?
    var format: String?
    var height: Int?
    var width: Int?
    
    init(json: [String:Any]) {
        url = json["url"] as? String
        format = json["format"] as? String
        height = json["height"] as? Int
        width = json["width"] as? Int
    }
}
