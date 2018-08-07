//
//  User.swift
//  Winners
//
//  Created by Tommy Nguyen on 8/6/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import Foundation

class User {

    var email: String?
    var names: String?
    var password: String?
    var going: Bool?
    
    init(nameText: String, isGoing: Bool) {
        names = nameText
        going = isGoing
    }
}
