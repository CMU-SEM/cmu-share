//
//  OrderDetailController.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/22/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class OrderDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var ref: DatabaseReference!
    var joinOrderList = [JoinOrder]()
    var currentUId: String!
    var orderId: String!
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var numJoinerLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setCurrentUserId()
        loadOrders()

        let detailCellNib = UINib(nibName:"DetailTableViewCell", bundle: nil)
        tableView.register(detailCellNib, forCellReuseIdentifier: "detailCell")
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.performSegue(withIdentifier: "detailToOrderSegue", sender: self)
    }
    
    func setCurrentUserId() {
        let user = Auth.auth().currentUser
        currentUId = user!.uid
    }
    func loadOrders() {
        // fetch the current order details
        ref.child("orders").observe(DataEventType.value) { (snapshot) in
            let postDic = snapshot.value as? [String: AnyObject]
            if(postDic != nil) {
                for (uid, item) in postDic! {
                    let order = Order(dict: item as! [String : AnyObject], uid: uid)
                    print(order.uid)
                    if (self.currentUId != nil && order.uid == self.orderId) {
                        self.restaurantNameLabel.text = order.name
                        self.orderTimeLabel.text = "\(order.hr) : \(order.min)"
                        self.numJoinerLabel.text = String(order.joinerCount)
                        self.feeLabel.text = String(order.fee)
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
                        self.joinOrderList.append(joinOrder)
                    }
                }
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return joinOrderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        let joinerObj = self.joinOrderList[indexPath.row] as JoinOrder
        
        
        cell.foodItem1.text = "\(joinerObj.foodItem1)"
        cell.quantity1.text = "\(joinerObj.quantity1)"
        cell.size1.text = "\(joinerObj.size1)"
        
        cell.foodItem2.text = joinerObj.foodItem2 == "" ? "N/A" : joinerObj.foodItem2;
        cell.quantity2.text = joinerObj.quantity2 == "" ? "N/A" : joinerObj.quantity2;
        cell.size2.text = joinerObj.size2 == "" ? "N/A" : joinerObj.size2;
        
        cell.selectionStyle = .none;
        cell.viewWrapper.layer.borderColor = UIColor.lightGray.cgColor;
        cell.viewWrapper.layer.borderWidth = 0.3;
        cell.viewWrapper.layer.cornerRadius = 5;
        
        cell.viewWrapper.layer.shadowColor = UIColor.lightGray.cgColor
        cell.viewWrapper.layer.shadowOpacity = 0.8
        cell.viewWrapper.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.viewWrapper.layer.shadowRadius = 4
        
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}
