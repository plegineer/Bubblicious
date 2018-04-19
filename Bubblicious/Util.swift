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
    
    class func saveBool(_ val:Bool, forKey key:String){
        UserDefaults.standard.set(val, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
