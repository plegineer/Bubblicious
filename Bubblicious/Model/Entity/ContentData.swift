//
//  ContentData.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/10.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ContentData {
    
    let imageUrl: String
    let title: String
    let description: String
    
    struct ParamKey {
        static let imageUrl = "keyImageUrl"
        static let title = "keyTitle"
        static let description = "keyDescription"
    }
    
    init(data: [String: String]) {
        if let imageUrl = data[ParamKey.imageUrl] {
            self.imageUrl = imageUrl
        } else {
            self.imageUrl = ""
        }
        
        if let title = data[ParamKey.title] {
            self.title = title
        } else {
            self.title = ""
        }
        
        if let description = data[ParamKey.description] {
            self.description = description
        } else {
            self.description = ""
        }
    }
}
