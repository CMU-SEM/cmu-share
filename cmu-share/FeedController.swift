//
//  feedController.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/14/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class feedController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var orderList = [Order]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        loadOrders()
        // Do any additional setup after loading the view.
        
        let feedCellNib = UINib(nibName:"FeedTableViewCell", bundle: nil)
        tableView.register(feedCellNib, forCellReuseIdentifier: "feedCell")
        
        
    }
    
    @IBAction func prototypeAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "FeedToPrototypeSegue", sender: self)
    }
    @IBAction func createAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "FeedToCreateSegue", sender: self)
    }
    
    
    func loadOrders() {
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
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return orderList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell;
        let orderObj = self.orderList[indexPath.row] as Order;
        cell.creatorName.text = orderObj.creatorName;
        cell.restaurantName.text = orderObj.name;
        cell.orderTime.text  = "\(orderObj.hr) : \(orderObj.min)";
        cell.numOfPeople.text  = "\(orderObj.joinerCount) person(s)";
        cell.deliveryFee.text  = "\(orderObj.dollar).\(orderObj.cent) $";
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
