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
    
    func post(callback: @escaping (_ error: Error?) -> Void) {
        let url = Const.Api.urlSuccess
        Log.d(url)
    
        // TODO: 本来は、リクエストの際にパラメーターに詰めるが、今回サーバー側の実装はないため、何もしない
//        let email = params["email"]
//        let password = params["password"]

        Alamofire.request(url)
            .responseJSON { response in
                
                switch response.result {
                    case .failure(let error):
                        Log.p(error)
                        callback(error)
                    case .success(let responseObject):
                        Log.p("Resonse of \(url):")
                        Log.p(responseObject)
                        let json = JSON(responseObject)
                        
                        _ = LoginResult(json: json["result"])
                        callback(nil)
                }
        }
    }
    
    func isAvailableAccessToken() -> Bool {
        let accessToken = UserDefaults.standard.object(forKey: Const.Key.accessToken)
        return accessToken != nil
    }
}
