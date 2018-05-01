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
        
        let keys = [String]((json.dictionaryObject?.keys)!)
        let contentsCount: Int = keys.count
        for i in 0 ..< contentsCount {
            let arrayValue = keys[i]
            self.contentsDataList.append(arrayValue)
        }
        
        let content1Count: Int = (json[self.contentsDataList[0]].array?.count)!
        for i in 0 ..< content1Count {
            let arrayValue = json[self.contentsDataList[0]].array![i].string
            self.content1DataList.append(arrayValue!)
        }
        
        let content2Count: Int = (json[self.contentsDataList[1]].array?.count)!
        for i in 0 ..< content2Count {
            let arrayValue = json[self.contentsDataList[1]].array![i].string
            self.content2DataList.append(arrayValue!)
        }
        
        let content3Count: Int = (json[self.contentsDataList[2]].array?.count)!
        for i in 0 ..< content3Count {
            let arrayValue = json[self.contentsDataList[2]].array![i].string
            self.content3DataList.append(arrayValue!)
        }
    }
}
