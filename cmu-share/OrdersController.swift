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
    var joinOrderList = [Order]()
    var createOrderList = [Order]()
    var currentUId: String!
    var selectedSegment = 0
    
    @IBAction func switchAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedSegment = 0
        }else{
            selectedSegment = 1
        }
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setCurrentUserId()
        loadOrders()
        
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
            self.joinOrderList = []
            let postDic = snapshot.value as? [String: AnyObject]
            if(postDic != nil) {
                for (uid, item) in postDic! {
                    let order = Order(dict: item as! [String : AnyObject], uid: uid)
                    if (self.currentUId != nil && order.creator == self.currentUId!) {
                        self.createOrderList.append(order);
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (selectedSegment == 0) {
            return createOrderList.count
        }else{
            return joinOrderList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (selectedSegment == 0) {
            let createCell = tableView.dequeueReusableCell(withIdentifier: "createCell", for: indexPath) as! CreateTableViewCell
            let orderObj = self.createOrderList[indexPath.row] as Order
            createCell.creatorName.text = orderObj.creatorName
            createCell.restaurantName.text = orderObj.name
            createCell.orderTime.text  = "\(orderObj.hr) : \(orderObj.min)"
            createCell.numOfPeople.text  = "\(orderObj.joinerCount) person(s)"
            createCell.deliveryFee.text  = "\(orderObj.dollar).\(orderObj.cent) $"
            createCell.selectionStyle = .none
            createCell.viewWrapper.layer.borderColor = UIColor.lightGray.cgColor
            createCell.viewWrapper.layer.borderWidth = 0.3
            createCell.viewWrapper.layer.cornerRadius = 5
            
            createCell.viewWrapper.layer.shadowColor = UIColor.lightGray.cgColor
            createCell.viewWrapper.layer.shadowOpacity = 0.8
            createCell.viewWrapper.layer.shadowOffset = CGSize(width: -1, height: 1)
            createCell.viewWrapper.layer.shadowRadius = 4
            
            createCell.delegate = self;
            return createCell;
        }else{
            let joinCell = tableView.dequeueReusableCell(withIdentifier: "joinCell", for: indexPath) as! JoinTableViewCell
            let orderObj = self.joinOrderList[indexPath.row] as Order
            joinCell.creatorName.text = orderObj.creatorName
            joinCell.restaurantName.text = orderObj.name
            joinCell.orderTime.text  = "\(orderObj.hr) : \(orderObj.min)"
            joinCell.numOfPeople.text  = "\(orderObj.joinerCount) person(s)"
            joinCell.deliveryFee.text  = "\(orderObj.dollar).\(orderObj.cent) $"
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
        return 250.0
    }
    
    func didTapClose(_ sender: CreateTableViewCell) {
        self.performSegue(withIdentifier: "OrderToStatusSegue", sender: nil)
    }
}
