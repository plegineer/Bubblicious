//
//  UserInfo.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/08.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation

struct UserInfo {
    let userId: Int
    var familyName: String?
    var firstName: String?
    var familyNameKana: String?
    var firstNameKana: String?
    var birthday: Date?
    var postalCode: String? // ハイフン無し
    var prefecture: String? // 都道府県コード、1が北海道、47が沖縄
    var address1: String? // 市区
    var address2: String? // 町村・番地
    var address3: String? // マンション・アパート名
    var telMain: String?
    var telSub: String?
    var fax: String?
    var gender: String?
    var bloodType: String?
    
    init() {
        // Login時にUserDefaultにUserIdを保存しておく
        // init時にUserDefaultからUserIdを読み込んで自分に設定する
        self.userId = 0
    }
    
    func description(message: String) {
        print()
    }

    
}
