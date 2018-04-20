//
//  Const.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/20.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation

struct Const {
    
    struct Api {
        static let urlSuccess = "https://dl.dropboxusercontent.com/s/7vi69591lzb88pb/login_response_success.json"
        static let urlError = "https://dl.dropboxusercontent.com/s/78s2tqd8cwem1gr/response_error.json"
    }
    
    struct Key {
        static let kAccessToken       = "KeyAccessToken"
        static let kAcesssTokenExpire = "KeyAccessTokenExpire"
        static let kRefreshToken      = "KeyRefreshToken"
    }
}
