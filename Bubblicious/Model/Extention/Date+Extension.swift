//
//  Date+Extension.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/08.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation

private let formatter: DateFormatter = {
    let formatter: DateFormatter = DateFormatter()
    formatter.timeZone = NSTimeZone.system
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.calendar = Calendar(identifier: .gregorian)
    return formatter
}()

public extension Date {
    
    // Date → String
    func string(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> String {
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    // String → Date
    init?(dateString: String, dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") {
        formatter.dateFormat = dateFormat
        guard let date = formatter.date(from: dateString) else { return nil }
        self = date
    }
}
