//
//  JoinOrder.swift
//  cmu-share
//
//  Created by Pattarasai Markpeng on 10/21/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class JoinOrder: NSObject {
    var uid: String;
    var orderId: String;
    var joinerId: String;
    var joinerDisplayName: String;
    var foodItem1: String;
    var quantity1: Int;
    var size1:String;
    var foodItem2:String;
    var quantity2:Int;
    var size2:String;
    
    
    init(uid: String, orderId: String, joinerId: String, joinerDisplayName: String, foodItem1: String, quantity1: Int, size1: String, foodItem2:String, quantity2:Int, size2: String) {
        self.uid = uid;
        self.orderId = orderId;
        self.joinerId = joinerId;
        self.joinerDisplayName = joinerDisplayName;
        self.foodItem1 = foodItem1;
        self.foodItem2 = foodItem2;
        self.quantity1 = quantity1;
        self.quantity2 = quantity2;
        self.size1 = size1;
        self.size2 = size2;
    }
    
    init(dict: [String: AnyObject], uid:String) {
        self.uid = uid
        self.orderId = dict["orderId"] as! String
        self.joinerId = dict["joinerId"] as! String
        self.joinerDisplayName = dict["joinerDisplayName"] as! String
        self.foodItem1 = dict["foodItem1"] as! String
        self.foodItem2 = dict["foodItem2"] as! String
        self.quantity1 = dict["quantity1"] as! Int
        self.quantity2 = dict["quantity2"] as! Int
        self.size1 = dict["size1"] as! String
        self.size2 = dict["size2"] as! String
    }
    
    func toDataDict() -> [String: Any] {
        return [
            "orderId" : self.orderId,
            "joinerId" : self.joinerId,
            "joinerDisplayName" : self.joinerDisplayName,
            "foodItem1": self.foodItem1,
            "foodItem2": self.foodItem2,
            "quantity1": self.quantity1,
            "quantity2" : self.quantity2,
            "size1": self.size1,
            "size2": self.size2
        ];
    }
}
