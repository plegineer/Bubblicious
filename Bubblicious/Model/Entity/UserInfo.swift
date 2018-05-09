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
    
    // APIの仕様等によっては、Optional型の必要はないが、今回はOptionalを許容した形で設計
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
    
    struct ParamKey {
        static let name = "keyName"
        static let kanaName = "keyKanaName"
        static let birthday = "keyBirthday"
        static let gender = "keyGender"
        static let bloodType = "keyBloodType"
        static let postalCode = "keyPostalCode"
        static let address = "keyAddress"
        static let telMain = "keyTelMain"
        static let telSub = "keyTelSub"
        static let fax = "keyFax"
    }
    
    init() {
        // Login時にUserDefaultにUserIdを保存しておく
        // init時にUserDefaultからUserIdを読み込んで自分に設定する
        self.userId = 0
    }
    
    func displayParams() -> [String: String] {
        var params: [String: String] = [:]
        params[ParamKey.name] = self.nameParam()
        params[ParamKey.kanaName] = self.kanaNameParam()
        params[ParamKey.birthday] = self.birthdayParam()
        params[ParamKey.gender] = self.genderParam()
        params[ParamKey.bloodType] = self.bloodTypeParam()
        params[ParamKey.postalCode] = self.postalCodeParam()
        params[ParamKey.address] = self.addressParam()
        params[ParamKey.telMain] = self.telMainParam()
        params[ParamKey.telSub] = self.telSubParam()
        params[ParamKey.fax] = self.faxParam()
        return params
    }
    
    // MARK: - Private Method
    
    private func nameParam() -> String {
        var param = ""
        if let familyName = self.familyName {
            param += familyName
        }
        
        if let firstName = self.firstName {
            param += firstName
        }
        return param
    }
    
    private func kanaNameParam() -> String {
        var param = ""
        if let familyNameKana = self.familyNameKana {
            param += familyNameKana
        }
        if let firstNameKana = self.firstNameKana {
            param += firstNameKana
        }
        return param
    }
    
    private func birthdayParam() -> String {
        // TODO: format確認！
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.system
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy/M/d"

        var param = ""
        if let birthDay = self.birthday {
            param += formatter.string(from: birthDay)
        }
        return param
    }
    
    private func genderParam() -> String {
        var param = ""
        if let gender = self.gender {
            param += Helper.toGenderPreview(from: gender)
        }
        return param
    }
    
    private func bloodTypeParam() -> String {
        var param = ""
        if let bloodType = self.bloodType {
            param += bloodType
        }
        return param
    }
    
    private func postalCodeParam() -> String {
        // TODO: "-"つける?
        var param = ""
        if let postalCode = self.postalCode {
            param += postalCode
        }
        return param
    }
    
    private func addressParam() -> String {
        var param = ""
        if let prefectureCode = self.prefecture, let prefectureName = Helper.toPrefName(from: prefectureCode) {
            param += prefectureName
        }
        
        if let address1Str = self.address1 {
            param += address1Str
        }
        
        if let address2Str = self.address2 {
            param += address2Str
        }
        
        if let address3Str = self.address3 {
            param += address3Str
        }
        return param
    }
    
    private func telMainParam() -> String {
        var param = ""
        if let telMain = self.telMain {
            param += telMain
        }
        return param
    }
    
    private func telSubParam() -> String {
        var param = ""
        if let telSub = self.telSub {
            param += telSub
        }
        return param
    }
    
    private func faxParam() -> String {
        var param = ""
        if let fax = self.fax {
            param += fax
        }
        return param
    }
}
