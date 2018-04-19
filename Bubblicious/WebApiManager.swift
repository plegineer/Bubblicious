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
    
    func post(_ params: [String: String], callback: @escaping (_ error: Error?) -> Void) {
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
//                    let loginResult: LoginResult = LoginResult(json: json)
                    
                    self.saveTokenIfNeeded(json["result"])
                    callback(nil)
                }
        }
    }
    
    func isAvailableAccessToken() -> Bool {
        let accessToken = UserDefaults.standard.object(forKey: "accessToken")
        return accessToken != nil
    }
    
    private func saveTokenIfNeeded(_ result: JSON?) {
        guard let result = result else {
            return
        }
        
        if let accessToken = result["auth"]["accessToken"].string {
            Util.saveObject(accessToken, forKey: "accessToken")
            print("accessToken Saved!", accessToken)
        }
        
        if let refreshToken = result["auth"]["refreshToken"].string {
            Util.saveObject(refreshToken, forKey: "KeyRefreshToken")
        }
        
        if let expireDate = result["auth"]["expireDate"].string {
            Util.saveObject(expireDate, forKey: "KeyAccessTokenExpire")
        }
    }
}
