//
//  feedController.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/14/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class feedController: UIViewController, UITableViewDelegate, UITableViewDataSource, FeedCellDelegate {
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var orderList = [Order]()
    var currentUId: String!
    var orderId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setCurrentUserId()
        loadOrders()
        StatusUpdateUtil.observeUpdate(_vc: self);
        
        let feedCellNib = UINib(nibName:"FeedTableViewCell", bundle: nil)
        tableView.register(feedCellNib, forCellReuseIdentifier: "feedCell")
    }
    
    func setCurrentUserId() {
        let user = Auth.auth().currentUser;
        currentUId = user!.uid;
    }
    
    @IBAction func createAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "FeedToCreateSegue", sender: self)
    }
    
    func loadOrders() {
        ref.child("orders").observe(DataEventType.value) { (snapshot) in
            self.orderList = []
            let postDic = snapshot.value as? [String: AnyObject]
            if(postDic != nil) {
                for (uid, item) in postDic! {
                    let order = Order(dict: item as! [String : AnyObject], uid: uid)
                    self.orderList.append(order);
                }
                
                self.orderList = self.orderList.sorted(by: { $0.hr < $1.hr })
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        let orderObj = self.orderList[indexPath.row] as Order
        
        // calculate shared delivery fee
        cell.deliveryFee.text  = "\(Double(round(100*orderObj.fee/Double(orderObj.joinerCount+1))/100)) $";
        cell.creatorName.text = orderObj.creatorName;
        cell.restaurantName.text = orderObj.name;
        cell.orderTime.text  = "\(orderObj.hr) : \(orderObj.min)";
        cell.numOfPeople.text  = "\(orderObj.joinerCount) person(s)";
        cell.selectionStyle = .none;
        cell.viewWrapper.layer.borderColor = UIColor.lightGray.cgColor;
        cell.viewWrapper.layer.borderWidth = 0.3;
        cell.viewWrapper.layer.cornerRadius = 5;
        
        cell.viewWrapper.layer.shadowColor = UIColor.lightGray.cgColor
        cell.viewWrapper.layer.shadowOpacity = 0.8
        cell.viewWrapper.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.viewWrapper.layer.shadowRadius = 4
        
        if(self.currentUId != nil && orderObj.creator == self.currentUId!) {
            cell.joinButton.isEnabled = false;
            cell.joinButton.backgroundColor = UIColor.lightGray;
            cell.joinButton.titleLabel!.textColor = UIColor.white;
        } else {
            cell.joinButton.isEnabled = true;
            cell.joinButton.backgroundColor = UIColor.red;
            cell.joinButton.titleLabel!.textColor = UIColor.white;
        }
        
        cell.delegate = self;
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func didTapJoin(_ sender: FeedTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        
        // get order clicked
        let order = self.orderList[tappedIndexPath.row] as Order;
        orderId = order.uid
        self.performSegue(withIdentifier: "feedToJoinSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier! == "feedToJoinSegue") {
            let joinOrderController = segue.destination as! joinOrderController
            joinOrderController.orderId = orderId
        }
    }
}
