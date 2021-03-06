//
//  Log.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/04/20.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation

class Log {
    
    class func p(_ item: Any) {
        #if DEBUG
        print(item)
        #endif
    }
    
    class func d (
        _ message: String = "",
        function: String = #function,
        file: String = #file,
        line: Int = #line) {
        #if DEBUG
        var filename = file
        if let match = filename.range(of: "[^/]*$", options: .regularExpression) {
            filename = String(filename[match])
        }
        NSLog("[DEBUG] %@ %@ [Line %d] %@", filename, function, line, message)
        #endif
    }
}
