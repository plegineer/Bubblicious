//
//  UserModel.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/04/20.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import SwiftyJSON

class UserModel {
    
    private(set) var loginResult: LoginResult?
    
    func login(_ params: [String: String], _ path: String, callback:@escaping (_ error: Error?) -> Void) {
        
        // 本来ならばここでURLを組み立てる
//        let postUrl = Const.apiBaseUrl + path
        
        let email = params["email"]
        let password = params["password"]
        
        let answerEmail = "hoge@email.com"
        let answerPassword = "hoge"
        
        // 本来: ログイン判定はサーバ側で行う
        // 今回: サーバー側の実装はないため、アプリ側でログインチェック(文字列が一致しているか)を行う
        let isLogined = email == answerEmail && password == answerPassword
        let urlString = isLogined ? Const.urlSuccess : Const.urlError
        let url = URL(string: urlString)
        
        WebApiManager.shared.post(params: params, url: url!, callback: {(json, error) in
            
            if let error = error {
                callback(error)
                return
            }
            
            guard let json = json else {
                callback(NSError(
                    domain: Const.Api.Domain, code: -90000,
                    userInfo: [NSLocalizedFailureReasonErrorKey: "データ取得に失敗しました"]
                ))
                return
            }
            
            self.loginResult = LoginResult(json: json["result"])
            callback(nil)
        })
    }
}
