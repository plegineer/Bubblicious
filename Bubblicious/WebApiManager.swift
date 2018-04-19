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
    
    private let urlSuccess = "https://dl.dropboxusercontent.com/s/7vi69591lzb88pb/login_response_success.json"
    private let urlError = "https://dl.dropboxusercontent.com/s/78s2tqd8cwem1gr/response_error.json"
    
    func post(callback: @escaping (_ error: Error?) -> Void) {
        print("WebApiManager")
        let url = urlSuccess
        
        Alamofire.request(url)
            .responseJSON { response in
//                print(response.result.value) // Optional
//                print(response.result) // SUCCESS
                
                switch response.result {
                case .failure(let error):
                    callback(error)
                case .success(let responseObject):
                    let json = JSON(responseObject)
                    let accessToken = json["result"]["auth"]["accessToken"]
                    print("success",accessToken)
                    callback(nil)
                }
        }
    }
    
    func isAvailableAccessToken() -> Bool {
        let accessToken = UserDefaults.standard.object(forKey: "accessToken")
        return accessToken != nil
    }
}
