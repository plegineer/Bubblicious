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
    
    private let urlSuccess = "https://dl.dropboxusercontent.com/s/7vi69591lzb88pb/login_response_success.json"
    private let urlError = "https://dl.dropboxusercontent.com/s/78s2tqd8cwem1gr/response_error.json"
    
    func post(callback: @escaping (_ error: Error?) -> Void) {
        print("WebApiManager")
        var request = urlSuccess
        
        Alamofire.request(request)
            .responseJSON(completionHandler: {(response: DataResponse<Any>) in
                
                switch response.result {
                case .failure(let error):
                    print(response)
                    return
                case .success(let responseObject):
                    print("success")
                    let json = JSON(responseObject)
                    if let errorObj = json["error"].dictionary {
                        
                        }
                    callback(nil)
                }
                
            }
        
        
        
        
        
        
        )
    }
    
    func isAvailableAccessToken() -> Bool {
        let accessToken = UserDefaults.standard.object(forKey: "accessToken")
        return accessToken != nil
    }
}
