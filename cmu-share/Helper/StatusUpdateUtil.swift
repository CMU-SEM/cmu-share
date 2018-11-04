//
//  StatusUpdateUtil.swift
//  cmu-share
//
//  Created by Pattarasai Markpeng on 11/3/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class StatusUpdateUtil {
    static var joinOrderList: [String: Bool] = [:]
    static func observeUpdate(_vc: UIViewController) {
        var ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let userId = user!.uid
        
        fetchJoiningOrderAndObserveOrder(userId: userId, ref: ref, _vc:_vc);
      
    }
    
    static func fetchJoiningOrderAndObserveOrder(userId: String, ref: DatabaseReference, _vc: UIViewController)  {
        ref.child("joinOrder").observe(DataEventType.value) { (snapshot) in
            self.joinOrderList =  [:]
            let postDic = snapshot.value as? [String: AnyObject]
            if(postDic != nil) {
                for (uid, item) in postDic! {
                    let joinOrder = JoinOrder(dict: item as! [String : AnyObject], uid: uid)
                    if (joinOrder.joinerId == userId) {
                        StatusUpdateUtil.joinOrderList[joinOrder.orderId] = true;
                    }
                }
            }
            
            observeOrder(ref: ref, _vc: _vc);
        }
    }
    
    static func observeOrder(ref: DatabaseReference, _vc: UIViewController) {
        ref.child("orders").observe(DataEventType.childChanged) { (snapshot) in
            let postDic = snapshot.value as! [String: AnyObject]
            if(postDic != nil) {
                let order = Order(dict: postDic, uid: postDic["orderId"] as! String)
                if(joinOrderList[order.uid] != nil) {
                    let msg = "Your order with \(order.creatorName) is updated! \nResturant: \(order.name) \n \nYou can see the update in Order Management";
                    let alert = UIAlertController(title: "Order Update!", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    }))
                  _vc.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}
