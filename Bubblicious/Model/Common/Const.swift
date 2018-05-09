//
//  Const.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/20.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation

struct Const {
    
    static let apiBaseUrl      = "http://xxxxx" // 例
    static let urlSuccess      = "https://dl.dropboxusercontent.com/s/7vi69591lzb88pb/login_response_success.json"
    static let urlError        = "https://dl.dropboxusercontent.com/s/78s2tqd8cwem1gr/response_error.json"
    static let telephoneNumber = "telprompt://0000000000"
    
    struct Api {
        static let Domain = "Bubblicious"
    }
    
    struct Key {
        static let accessToken       = "KeyAccessToken"
        static let acesssTokenExpire = "KeyAccessTokenExpire"
        static let refreshToken      = "KeyRefreshToken"
    }
    
    struct Alert {
        static let errorTitle = "エラー"
        static let locationManagerDidUpdateTitle    = "現在位置"
        static let locationManagerDidFailMessage    = "位置情報の取得に失敗しました"
        static let locationManagerDeniedTitle       = "位置情報サービスの設定が「無効」になっています"
        static let locationManagerDeniedMessage     = "設定 > プライバシー > 位置情報サービス で、位置情報サービスの利用を許可して下さい"
        static let locationManagerRestrictedTitle   = "位置情報サービスの設定が制限されているため利用出来ません"
        static let locationManagerRestrictedMessage = "設定 > 一般 > 機能制限 で、制限を解除して下さい"
        static let openMapLocationErrorMessage      = "先に位置情報を取得して下さい"
    }
    
    struct Map {
        static let BaseUrlFirst  = "http://maps.apple.com/?daddr="
        static let BaseUrlSecond = "&dirflg=d"
    }
}
