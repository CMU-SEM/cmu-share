//
//  RealtimeDBViewController.swift
//  cmu-share
//
//  Created by Pattarasai Markpeng on 10/6/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class RealtimeDBViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var detailLabel: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
    
    var orderList = [Order]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        loadOrders()
    }
    
    func loadOrders() {
        // To Do: to observe when the whole list is changed
        // Response From Google: the new list of orders
        ref.child("orders").observe(DataEventType.value) { (snapshot) in
            self.orderList = []
            var postDic = snapshot.value as? [String: AnyObject]
            if(postDic != nil) {
                for (uid, item) in postDic! {
                    let order = Order(dict: item as! [String : AnyObject], uid: uid)
                    self.orderList.append(order);
                }
                self.tableView.reloadData()
            }
        }
        
        // To Do: to observe when the an item is changed
        // Response From Google: an orders of which properties are changed
        ref.child("orders").observe(DataEventType.childChanged) { (snapshot) in
            self.orderList = []
            let postDic = snapshot.value as? [String: AnyObject]
            if(postDic != nil) {
                let order = Order(dict: postDic as! [String : AnyObject], uid: "")
                let alert = UIAlertController(title: "My Alert", message: "Order: \(order.name) is changed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
      
    }
    
    @IBAction func editRestaurant(_ sender: UIButton) {
        // To Do: to edit the current item
        // Response From Google: nothing, it will trigger .childChanged or .value
        ref.child("orders").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            var postDic = snapshot.value as? [String: AnyObject]
             if(postDic != nil) {
                var targetItem: Order? = nil;
                for (uid, item) in postDic! {
                    let order = Order(dict: item as! [String : AnyObject], uid: uid)
                    if(self.nameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == order.name.trimmingCharacters(in: .whitespacesAndNewlines)) {
                        targetItem = order;
                        break;
                    }
                }
                if(targetItem != nil) {
                    self.ref.child("orders").child(targetItem!.uid).updateChildValues(["detail" : self.detailLabel.text]) {
                        (error:Error?, ref:DatabaseReference) in
                        if let error = error {
                            print("Data could not be saved: \(error).")
                        } else {
                            print("Data saved successfully!")
                        }
                    }
                }
            }
        })
    }
    

    @IBAction func addRestaurant(_ sender: Any) {
        let orderRef = Database.database().reference().child("orders").childByAutoId();
        
        let orderObj = [
            "restaurantName" : nameLabel.text!,
            "detail": detailLabel.text!,
            "timestamp": [".sv", "timestamp"]
        ] as [String: Any]
        
        orderRef.setValue(orderObj) { (error, ref) in
            print("error")
        }        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath) as! RealtimeDBTableViewCell
        if(indexPath.row > orderList.count) {
            return cell;
        }
        
        let order = orderList[indexPath.row] as Order
        cell.nameLabel.text = order.name;
        cell.detailLabel.text = order.detail;
        return cell;
    }

}
