//
//  Util.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation
import CalculateCalendarLogic

class Util {
    
    class func saveObject(_ obj:Any?, forKey key: String) {
        UserDefaults.standard.set(obj, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func loadObject(_ key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func saveBool(_ val:Bool, forKey key:String) {
        UserDefaults.standard.set(val, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func loadBool(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    class func clearAllSavedData() {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }
    
    class func calendarColor(_ date: Date) -> UIColor {
        // 祝日: 赤色
        if Util.isHoliday(date) {
            return UIColor.red
        }
        
        let weekday = Util.weekDayIndex(date)
        if weekday == 1 {
            // 日曜日: 赤色
            return UIColor.red
        } else if weekday == 7 {
            // 土曜日: 青色
            return UIColor.blue
        }
        
        // 上記以外: 黒色
        return UIColor.black
    }
    
    class func weekDayIndex(_ date: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.weekday, from: date)
    }
    
    class func isHoliday(_ date: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
}
