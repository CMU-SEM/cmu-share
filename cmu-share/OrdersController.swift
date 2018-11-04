//
//  OrdersController.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/20/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class OrdersController: UIViewController, UITableViewDelegate, UITableViewDataSource, CreateCellDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var joinOrderList = [JoinOrder]()
    var createOrderList = [Order]()
    var joinOrderDetailList = [Order]()
    var currentUId: String!
    var selectedSegment = 0
    
    let CREATE_ORDER_TAB_SEGMENT_ID = 0
    let JOIN_ORDER_TAB_SEGMENT_ID = 1
    var orderId: String!
    
    @IBAction func switchAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedSegment = CREATE_ORDER_TAB_SEGMENT_ID
        }else{
            selectedSegment = JOIN_ORDER_TAB_SEGMENT_ID
        }
        loadOrders()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setCurrentUserId()
        loadOrders()
        StatusUpdateUtil.observeUpdate(_vc: self);
        
        let createCellNib = UINib(nibName:"CreateTableViewCell", bundle: nil)
        tableView.register(createCellNib, forCellReuseIdentifier: "createCell")
        
        let joinCellNib = UINib(nibName:"JoinTableViewCell", bundle: nil)
        tableView.register(joinCellNib, forCellReuseIdentifier: "joinCell")
    }
    
    func setCurrentUserId() {
        let user = Auth.auth().currentUser
        currentUId = user!.uid
    }
    
    func loadOrders() {
        ref.child("orders").observe(DataEventType.value) { (snapshot) in
            self.createOrderList = []
            let postDic = snapshot.value as? [String: AnyObject]
            if(postDic != nil) {
                for (uid, item) in postDic! {
                    let order = Order(dict: item as! [String : AnyObject], uid: uid)
                    if (self.currentUId != nil && order.creator == self.currentUId!) {
                        self.createOrderList.append(order);
                    }
                }
            }
            self.createOrderList = self.createOrderList.sorted(by: { $0.hr > $1.hr })
            self.tableView.reloadData()
        }
       
        
        ref.child("joinOrder").observe(DataEventType.value) { (snapshot) in
            self.joinOrderList = []
            self.joinOrderDetailList = []
            let postDic = snapshot.value as? [String: AnyObject]
            if(postDic != nil) {
                for (uid, item) in postDic! {
                    let joinOrder = JoinOrder(dict: item as! [String : AnyObject], uid: uid)
                    if (self.currentUId != nil && joinOrder.joinerId == self.currentUId!) {
                        self.joinOrderList.append(joinOrder);
                        self.ref.child("orders").observe(DataEventType.value) { (snapshot) in
                            let postDic = snapshot.value as? [String: AnyObject]
                            if(postDic != nil) {
                                for (uid, item) in postDic! {
                                    let this_order = Order(dict: item as! [String : AnyObject], uid: uid)
                                    if (self.currentUId != nil && joinOrder.orderId == this_order.uid) {
                                        self.joinOrderDetailList.append(this_order);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (selectedSegment == CREATE_ORDER_TAB_SEGMENT_ID) {
            return createOrderList.count
        }else{
            return joinOrderList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (selectedSegment == CREATE_ORDER_TAB_SEGMENT_ID) {
            let createCell = tableView.dequeueReusableCell(withIdentifier: "createCell", for: indexPath) as! CreateTableViewCell
            let orderObj = self.createOrderList[indexPath.row] as Order
            createCell.creatorName.text = orderObj.creatorName
            createCell.restaurantName.text = orderObj.name
            createCell.orderTime.text  = "\(OrderTimeFomatter.format(hr: orderObj.hr, min: orderObj.min))"
            createCell.numOfPeople.text  = "\(orderObj.joinerCount) person(s)"
            createCell.deliveryFee.text  = "\(orderObj.fee) $"
            createCell.selectionStyle = .none
            createCell.viewWrapper.layer.borderColor = UIColor.lightGray.cgColor
            createCell.viewWrapper.layer.borderWidth = 0.3
            createCell.viewWrapper.layer.cornerRadius = 5
            
            createCell.viewWrapper.layer.shadowColor = UIColor.lightGray.cgColor
            createCell.viewWrapper.layer.shadowOpacity = 0.8
            createCell.viewWrapper.layer.shadowOffset = CGSize(width: -1, height: 1)
            createCell.viewWrapper.layer.shadowRadius = 4
            

            if(orderObj.status == Order.STATUS_OPEN) {
                createCell.closeButton.setTitle("Close", for: .normal)
            } else {
               createCell.closeButton.setTitle("Update", for: .normal)
            }
            
            createCell.delegate = self;
            return createCell;
        }else{
            let joinCell = tableView.dequeueReusableCell(withIdentifier: "joinCell", for: indexPath) as! JoinTableViewCell
            let orderObj = self.joinOrderList[indexPath.row] as JoinOrder
            if(self.joinOrderDetailList.count > indexPath.row) {
                let curOrder = self.joinOrderDetailList[indexPath.row] as Order
                
                joinCell.creatorName.text = curOrder.creatorName
                joinCell.restaurantName.text = curOrder.name
                joinCell.orderTime.text  = "\(OrderTimeFomatter.format(hr: curOrder.hr, min: curOrder.min))"
                joinCell.numOfPeople.text  = "\(curOrder.joinerCount) person(s)"
                joinCell.deliveryFee.text  = "\(Double(round(100*curOrder.fee/Double(curOrder.joinerCount))/100))$"
                joinCell.statusLabel.text = "\(curOrder.status)"
                joinCell.placeLabel.text = "\(curOrder.place)"
            }
            joinCell.foodItem1.text = "\(orderObj.foodItem1)"
            joinCell.quantity1.text = "\(orderObj.quantity1)"
            joinCell.size1.text = "\(orderObj.size1)"
            
            joinCell.foodItem2.text = orderObj.foodItem2 == "" ? "N/A" : orderObj.foodItem2;
            joinCell.quantity2.text = orderObj.quantity2 == "" ? "N/A" : orderObj.quantity2;
            joinCell.size2.text = orderObj.size2 == "" ? "N/A" : orderObj.size2;
            
            joinCell.selectionStyle = .none
            joinCell.viewWrapper.layer.borderColor = UIColor.lightGray.cgColor
            joinCell.viewWrapper.layer.borderWidth = 0.3
            joinCell.viewWrapper.layer.cornerRadius = 5
            
            joinCell.viewWrapper.layer.shadowColor = UIColor.lightGray.cgColor
            joinCell.viewWrapper.layer.shadowOpacity = 0.8
            joinCell.viewWrapper.layer.shadowOffset = CGSize(width: -1, height: 1)
            joinCell.viewWrapper.layer.shadowRadius = 4
            
            return joinCell;
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if (selectedSegment == CREATE_ORDER_TAB_SEGMENT_ID) {
            return 250.0
         } else {
            return 392.5
        }
    }
    
    func didTapClose(_ sender: CreateTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        
        // get order clicked
        let order = self.createOrderList[tappedIndexPath.row] as Order;
        orderId = order.uid
        self.performSegue(withIdentifier: "OrderToStatusSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier! == "OrderToStatusSegue") {
            let OrderDetailController = segue.destination as! OrderDetailController
            OrderDetailController.orderId = orderId
        }
    }
}
