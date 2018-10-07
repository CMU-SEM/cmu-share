//
//  Order.swift
//  cmu-share
//
//  Created by Pattarasai Markpeng on 10/6/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class Order: NSObject {
    var name: String
    var detail: String
    var uid: String
    
    init(name: String, detail: String, uid: String) {
        self.name = name;
        self.detail = detail;
        self.uid = uid;
    }
    
    init(dict: [String: AnyObject], uid:String) {
        self.name = dict["restaurantName"] as! String
        self.detail = dict["detail"] as! String
        self.uid = uid
    }
}
