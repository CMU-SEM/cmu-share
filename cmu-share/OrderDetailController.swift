//
//  OrderDetailController.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/22/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class OrderDetailController: UIViewController {
    var ref: DatabaseReference!
    var joinOrderList = [JoinOrder]()
    var orderList = [Order]()
    var currentUId: String!
    var orderId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setCurrentUserId()
        loadOrders()
    }

    func setCurrentUserId() {
        let user = Auth.auth().currentUser
        currentUId = user!.uid
    }
    
    func loadOrders() {
        // fetch the current order details
        ref.child("Order").observe(DataEventType.value) { (snapshot) in
            self.orderList = []
            let postDic = snapshot.value as? [String: AnyObject]
            if(postDic != nil) {
                for (uid, item) in postDic! {
                    let order = Order(dict: item as! [String : AnyObject], uid: uid)
                    if (self.currentUId != nil && order.uid == self.orderId) {
                        self.orderList.append(order);
                        break
                    }
                }
            }
        }
        // fetch the joiner details of current order
        ref.child("joinOrder").observe(DataEventType.value) { (snapshot) in
            self.joinOrderList = []
            let postDic = snapshot.value as? [String: AnyObject]
            if(postDic != nil) {
                for (uid, item) in postDic! {
                    let joinOrder = JoinOrder(dict: item as! [String : AnyObject], uid: uid)
                    if (self.currentUId != nil && joinOrder.orderId == self.orderId) {
                        self.joinOrderList.append(joinOrder);
                    }
                }
            }
        }
    }
}
