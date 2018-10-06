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
    
    init(name: String, detail: String) {
        self.name = name;
        self.detail = detail;
    }
}
