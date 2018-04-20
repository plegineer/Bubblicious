//
//  Util.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation

class Util {
    
    class func saveObject(_ obj:Any?, forKey key: String){
        UserDefaults.standard.set(obj, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func loadObject(_ key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func saveBool(_ val:Bool, forKey key:String){
        UserDefaults.standard.set(val, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func loadBool(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    // アプリ内の全てのKeyとValueを削除
    class func clearAllSavedData() {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }
}
