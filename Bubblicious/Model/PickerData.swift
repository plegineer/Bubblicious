//
//  PickerData.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/02.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class PickerData {
    private let jsonFile: String = "sample_picker_json"
    private var contents: [(String, JSON)] = []
    
    init() {
        self.loadJson()
    }
    
    func keys() -> [String] {
        return self.contents.map{($0.0)}
    }
    
    func values(key: String) -> [String] {
        var values: [String] = []
        let sameKeyContents = self.contents.filter{($0.0 == key)}
        if sameKeyContents.count == 1 {
            let tapple = sameKeyContents.first!
            let valuesJson = tapple.1.arrayValue
            let valuesString = valuesJson.map{($0.stringValue)}
            values = valuesString
        }
        return values
    }
    
    private func loadJson() {
        var jsonString: String!
        if let filePath = Bundle.main.path(forResource: jsonFile, ofType: "js") {
            do {
                jsonString = try String(contentsOfFile: filePath)
                let json: JSON = JSON(parseJSON: jsonString)
                self.contents = json.dictionaryValue.sorted{($0.key < $1.key)}
            } catch {
                Log.p("jsonファイルが見込めません")
            }
        } else {
            Log.p("指定されたファイルが見つかりません")
        }
    }
}
