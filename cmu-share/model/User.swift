//
//  User.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/14/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class User: NSObject {
    var email: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var uid: String
    
    init(email: String, firstName: String, lastName: String, phoneNumber: String, uid: String) {
        self.email = email;
        self.firstName = firstName;
        self.lastName = lastName;
        self.phoneNumber = phoneNumber;
        self.uid = uid;
    }
    
    init(dict: [String: AnyObject], uid:String) {
        self.email = dict["email"] as! String
        self.firstName = dict["firstName"] as! String
        self.lastName = dict["lastName"] as! String
        self.phoneNumber = dict["phoneNumber"] as! String
        self.uid = uid
    }
}
