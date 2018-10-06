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
        ref.child("orders").observe(DataEventType.value) { (snapshot) in
            self.orderList = []
            let postDic = snapshot.value as? [String: AnyObject]
            for (uid, item) in postDic! {
                let order = Order(name: item["restaurantName"] as! String, detail: item["detail"] as! String )
                self.orderList.append(order);
            }
            self.tableView.reloadData()
        }
        
        ref.child("orders").observe(DataEventType.childChanged) { (snapshot) in
            self.orderList = []
            let postDic = snapshot.value as? [String: AnyObject]
            for (uid, item) in postDic! {
                let order = Order(name: item["restaurantName"] as! String, detail: item["detail"] as! String )
                self.orderList.append(order);
            }
            self.tableView.reloadData()
        }
      
    }

    @IBAction func addRestaurant(_ sender: Any) {
        let orderRef = Database.database().reference().child("orders").childByAutoId();
        
        let orderObj = [
            "restaurantName" : nameLabel.text,
            "detail": detailLabel.text,
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
        
        let order = orderList[indexPath.row] as Order
        cell.nameLabel.text = order.name;
        cell.detailLabel.text = order.detail;
        return cell;
    }

}
