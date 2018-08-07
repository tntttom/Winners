//
//  Event.swift
//  Winners
//
//  Created by Tommy Nguyen on 8/1/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import Foundation

class Event {
    var address: String
    var city: String
    var date: String
    var time: String
    
    init(addressText: String, cityText: String, dateText: String, timeText: String) {
        address = addressText
        city = cityText
        date = dateText
        time = timeText
    }
}
