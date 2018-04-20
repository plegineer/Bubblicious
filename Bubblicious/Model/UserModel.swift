//
//  UserModel.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/20.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import SwiftyJSON

class UserModel {
    
    fileprivate(set) var loginResult: LoginResult?
    
    func login(_ params: [String: String], _ path: String, callback:@escaping (_ error: Error?) -> Void) {
        
        // 本来ならばここでURLを組み立てる
//        let postUrl = Const.apiBaseUrl + path
        
        let email = params["email"]
        let password = params["password"]
        
        let answerEmail = "hoge@email.com"
        let answerPassword = "hoge"
        
        // 本来はログイン判定はサーバ側で行うが、サーバー側の実装はないため、アプリ側で行う
        let isLogined = email == answerEmail && password == answerPassword
        let urlString = isLogined ? Const.urlSuccess : Const.urlError
        let url = URL(string: urlString)
        
        WebApiManager.sharedManager.post(params: params, url: url!, callback: {(json, error) in
            if let error = error {
                // ログインエラーの場合
                Log.d("Error\(error)")
                callback(error)
                return
            }
            
            if let json = json {
                if isLogined {
                    // ログインに成功している場合
                    self.loginResult = LoginResult(json: json)
                    callback(nil)
                } else {
                    // ログインに失敗している場合
                    if let errorObject = json["error"].dictionary {
                        if let code = errorObject["code"], let msg = errorObject["message"] {
                            let error = NSError(
                                domain: Const.Api.Domain, code: code.intValue,
                                userInfo: [NSLocalizedFailureReasonErrorKey: msg.stringValue]
                            )
                            callback(error)
                        }
                    }
                }
            }
        })
    }
}
