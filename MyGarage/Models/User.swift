//
//  User.swift
//  MyGarage
//
//  Created by mac on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var password: String?
//    var email: String?
    var name: String?
    
    
    init(name: String, password: String) {
        
//        self.email = email
        self.name = name
        self.password = password
    }
    
}
