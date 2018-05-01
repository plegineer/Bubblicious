//
//  DataListPickerView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/27.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataListPickerView {
    
    private(set) var contentsDataList: [String] = []
    private(set) var content1DataList: [String] = []
    private(set) var content2DataList: [String] = []
    private(set) var content3DataList: [String] = []
    
    init(json: JSON) {
        setProperties(json: json)
    }
    
    private func setProperties(json: JSON) {
        
        if let dictionary = json.dictionaryObject {
            let keyString = [String](dictionary.keys)
            let contentsCount: Int = keyString.count
            for i in 0 ..< contentsCount {
                let arrayValue = keyString[i]
                self.contentsDataList.append(arrayValue)
            }
        }
        
        if let content1 = json[self.contentsDataList[0]].array {
            let content1Count = content1.count
            for i in 0 ..< content1Count {
                let arrayValue = content1[i].string
                self.content1DataList.append(arrayValue!)
            }
        }
        
        if let content2 = json[self.contentsDataList[1]].array {
            let content2Count = content2.count
            for i in 0 ..< content2Count {
                let arrayValue = content2[i].string
                self.content2DataList.append(arrayValue!)
            }
        }
        
        if let content3 = json[self.contentsDataList[2]].array {
            let content3Count = content3.count
            for i in 0 ..< content3Count {
                let arrayValue = content3[i].string
                self.content3DataList.append(arrayValue!)
            }
        }
    }
}
