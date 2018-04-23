//
//  WebApiManager.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/18.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Alamofire
import SwiftyJSON

class WebApiManager {
    
    static let sharedManager = WebApiManager()
    
    func post(params: [String: String], url: URL, callback: @escaping (_ result: JSON? , _ error: Error?) -> Void) {
            
        Alamofire.request(url)
            .responseJSON { response in
                
                switch response.result {
                    case .failure(let error):
                        Log.p(error)
                        callback(nil, error)
                    case .success(let responseObject):
                        Log.p("Resonse of \(url):")
                        Log.p(responseObject)
                        let json = JSON(responseObject)
                        callback(json, nil)
                }
        }
    }
    
    func isAvailableAccessToken() -> Bool {
        let accessToken = UserDefaults.standard.object(forKey: Const.Key.accessToken)
        return accessToken != nil
    }
}
