//
//  Order.swift
//  cmu-share
//
//  Created by Pattarasai Markpeng on 10/6/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class Order: NSObject {
    static var STATUS_OPEN: String = "open";
    static var STATUS_CLOSE: String = "close";
    static var STATUS_PLACED: String = "Placed";
    static var STATUS_PROCESS: String = "Processing";
    static var STATUS_ON_THE_WAY: String = "On The Way";
    static var STATUS_DELIVERED: String = "Delivered";
    
    static var STATUS_LIST :[String] = [Order.STATUS_PROCESS, Order.STATUS_ON_THE_WAY, Order.STATUS_DELIVERED];
    
    var uid: String
    var creator: String
    var creatorName: String
    var name: String
    var detail: String
    var hr: Int
    var min: Int
    var fee: Double
    var joinerCount: Int
    var status: String
    var place: String
    var date: String
    
    init(creator: String, name: String, detail: String, uid: String, hr: Int, min: Int,
         fee: Double, joiner_count: Int, creatorName: String, status: String, place: String, date: String) {
        self.uid = uid
        self.creator = creator
        self.name = name
        self.detail = detail
        self.hr = hr
        self.min = min
        self.fee = fee
        self.joinerCount = joiner_count
        self.creatorName = creatorName
        self.status = status
        self.place = place
        self.date = date
    }
    
    init(dict: [String: AnyObject], uid:String) {
        self.uid = uid
        self.name = dict["restaurantName"] as! String
        self.detail = dict["detail"] as! String
        self.creator = dict["creator_id"] as! String
        self.detail = dict["detail"] as! String
        self.hr = dict["hr"] as! Int
        self.min = dict["min"] as! Int
        self.fee = dict["fee"] as! Double
        self.joinerCount = dict["joiner_count"] as! Int
        self.creatorName = dict["creatorName"] as! String
        self.status = dict["status"] as! String
        self.place = dict["place"] as! String
        self.date = dict["date"] as! String
    }
}
