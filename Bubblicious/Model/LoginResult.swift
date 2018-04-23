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

    private(set) var accessToken = ""
    private(set) var refreshToken = ""
    private(set) var expireDate = ""

    init(json: JSON) {
        setProperties(result: json)
    }

    private func setProperties(result: JSON) {
        if let accessToken = result["auth"]["accessToken"].string {
            self.accessToken = accessToken
        }

        if let refreshToken = result["auth"]["refreshToken"].string {
            self.refreshToken = refreshToken
        }

        if let expireDate = result["auth"]["expireDate"].string {
            self.expireDate = expireDate
        }
    }
}
