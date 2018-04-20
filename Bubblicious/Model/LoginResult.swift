//
//  LoginResult.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/20.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginResult {

    let accessToken = ""
    let refreshToken = ""

    init(json: JSON) {
        setProperties(result: json)
    }

    private func setProperties(result: JSON) {
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
