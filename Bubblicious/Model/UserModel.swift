//
//  UserModel.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/20.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import SwiftyJSON

class UserModel {
    
    func login(_ params: [String: String], callback:@escaping (_ error: Error?) -> Void) {
        
        WebApiManager.sharedManager.post(params: params, callback: {(error) in
            if let error = error {
                Log.d("Error\(error)")
                return
            }
            callback(nil)
        })
    }
}
