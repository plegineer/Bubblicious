//
//  LoginResult.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import SwiftyJSON


//MARK - ToDo
class LoginResult {
    var accessToken: String = ""
    var refreshToken: String = ""
    var expireDate: String = ""
    var id: String = ""
    var name: String = ""
    
    init(json: JSON) {
        setProperties(json: json)
    }
    
    private func setProperties(json: JSON) {
        self.accessToken = json["result"]["auth"]["accessToken"].stringValue
        print("success",self.accessToken)
    }
}
