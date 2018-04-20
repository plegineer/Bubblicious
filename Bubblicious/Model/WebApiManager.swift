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
    
    func post(_ params: [String: String], callback: @escaping (_ error: Error?) -> Void) {
        let url = Const.Api.urlSuccess
        print(url)
        
        Alamofire.request(url)
            .responseJSON { response in
                
                switch response.result {
                case .failure(let error):
                    print(error)
                    callback(error)
                case .success(let responseObject):
                    print("Resonse of ",url)
                    print(responseObject)
                    let json = JSON(responseObject)
                    self.saveTokenIfNeeded(json["result"])
                    callback(nil)
                }
        }
    }
    
    func isAvailableAccessToken() -> Bool {
        let accessToken = UserDefaults.standard.object(forKey: Const.Key.AccessToken)
        return accessToken != nil
    }
    
    private func saveTokenIfNeeded(_ result: JSON?) {
        guard let result = result else {
            return
        }
        
        if let accessToken = result["auth"]["accessToken"].string {
            Util.saveObject(accessToken, forKey: Const.Key.AccessToken)
            print("accessToken Saved!", accessToken)
        }
        
        if let refreshToken = result["auth"]["refreshToken"].string {
            Util.saveObject(refreshToken, forKey: Const.Key.RefreshToken)
        }
        
        if let expireDate = result["auth"]["expireDate"].string {
            Util.saveObject(expireDate, forKey: Const.Key.AcesssTokenExpire)
        }
    }
}
