//
//  User.swift
//  快手
//
//  Created by liulichao on 16/5/11.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: Int?
    var phone: String?
    var password: String?
    var name: String?
    
    override init() {
        super.init()
    }
    static func instanceWithDict(dict: NSDictionary) -> User {
        let u = User()
        u.id = dict["id"]?.integerValue
        u.name = dict["name"] as? String
        u.phone = dict["phone"] as? String
        u.password = dict["password"] as? String
        return u
    }
    
}
