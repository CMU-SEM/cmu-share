//
//  Joiner.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/14/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class Joiner: NSObject {
    var uid: String
    var joiner_id: String
    var order_id: String
    var menu_count: Int
    
    init(uid: String, joiner_id: String, order_id: String, menu_count: Int) {
        self.uid = uid
        self.joiner_id = joiner_id
        self.order_id = order_id
        self.menu_count = menu_count
    }
    
    init(dict: [String: AnyObject], uid:String) {
        self.uid = uid
        self.joiner_id = dict["joiner_id"] as! String
        self.order_id = dict["order_id"] as! String
        self.menu_count = dict["menu_count"] as! Int
    }
}
