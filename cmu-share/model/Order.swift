//
//  Order.swift
//  cmu-share
//
//  Created by Pattarasai Markpeng on 10/6/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class Order: NSObject {
    var uid: String
    var creator: String
    var name: String
    var detail: String
    var hr: Int
    var min: Int
    var dollar: Int
    var cent: Int
    var joiner_count: Int
    
    init(creator: String, name: String, detail: String, uid: String, hr: Int, min: Int,
         dollar: Int, cent: Int, joiner_count: Int) {
        self.uid = uid
        self.creator = creator
        self.name = name
        self.detail = detail
        self.hr = hr
        self.min = min
        self.dollar = dollar
        self.cent = cent
        self.joiner_count = joiner_count
    }
    
    init(dict: [String: AnyObject], uid:String) {
        self.uid = uid
        self.name = dict["restaurantName"] as! String
        self.detail = dict["detail"] as! String
        self.creator = dict["creator_id"] as! String
        self.name = dict["restaurantName"] as! String
        self.detail = dict["detail"] as! String
        self.uid = uid
        self.hr = dict["hr"] as! Int
        self.min = dict["min"] as! Int
        self.dollar = dict["dollar"] as! Int
        self.cent = dict["cent"] as! Int
        self.joiner_count = dict["joiner_count"] as! Int
    }
}
