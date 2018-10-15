//
//  User.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/14/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class User: NSObject {
    var uid: String
    var email: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    
    init(uid: String, email: String, firstName: String, lastName: String, phoneNumber: String) {
        self.uid = uid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
    
    init(dict: [String: AnyObject], uid:String) {
        self.uid = uid
        self.email = dict["email"] as! String
        self.firstName = dict["firstName"] as! String
        self.lastName = dict["lastName"] as! String
        self.phoneNumber = dict["phoneNumber"] as! String
    }
}
