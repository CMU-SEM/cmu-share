//
//  OrdersController.swift
//  cmu-share
//
//  Created by Sathish on 10/19/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
////
//
//import UIKit
//import Firebase
//
//class OrdersController: UIViewController, UITableViewDelegate, UITableViewDataSource{
//    @IBOutlet weak var tableView: UITableView!
//    var ref: DatabaseReference!
//    var orderList = [Order]()
//    var currentUId: String!
//    var selectedSegment = 0

//    @IBAction func swtichAction(_ sender: UISegmentedControl) {
//        // created order
//        if (sender.selectedSegmentIndex == 0) {
//            selectedSegment = 0
//        } else {
//            selectedSegment = 1
//        }
//        self.tableView.reloadData()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        ref = Database.database().reference()
//        setCurrentUserId()
//        loadOrders()
//
//        let createCellNib = UINib(nibName:"CreateTableViewCell", bundle: nil)
//        tableView.register(createCellNib, forCellReuseIdentifier: "createCell")
//        //
//        //        let joinCellNib = UINib(nibName:"JoinTableViewCell", bundle: nil)
//        //        tableView.register(joinCellNib, forCellReuseIdentifier: "joinCell")
//    }
//
//    func setCurrentUserId() {
//        let user = Auth.auth().currentUser;
//        currentUId = user!.uid;
//    }
//
//    func loadOrders() {
//        ref.child("orders").observe(DataEventType.value) { (snapshot) in
//            self.orderList = []
//            let postDic = snapshot.value as? [String: AnyObject]
//            if(postDic != nil) {
//                for (uid, item) in postDic! {
//                    let order = Order(dict: item as! [String : AnyObject], uid: uid)
//                    self.orderList.append(order);
//                }
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(orderList.count)
//        return orderList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let createCell = tableView.dequeueReusableCell(withIdentifier: "createCell", for: indexPath) as! CreateTableViewCell
//        //        let joinCell = tableView.dequeueReusableCell(withIdentifier: "joinCell", for: indexPath) as! JoinTableViewCell
//        let orderObj = self.orderList[indexPath.row] as Order;
//
//        //        if selectedSegment == 0 {
//        createCell.creatorName.text = orderObj.creatorName;
//        createCell.restaurantName.text = orderObj.name;
//        createCell.orderTime.text  = "\(orderObj.hr) : \(orderObj.min)";
//        createCell.numOfPeople.text  = "\(orderObj.joinerCount) person(s)";
//        createCell.deliveryFee.text  = "\(orderObj.dollar).\(orderObj.cent) $";
//        createCell.selectionStyle = .none;
//        createCell.viewWrapper.layer.borderColor = UIColor.lightGray.cgColor;
//        createCell.viewWrapper.layer.borderWidth = 0.3;
//        createCell.viewWrapper.layer.cornerRadius = 5;
//
//        createCell.viewWrapper.layer.shadowColor = UIColor.lightGray.cgColor
//        createCell.viewWrapper.layer.shadowOpacity = 0.8
//        createCell.viewWrapper.layer.shadowOffset = CGSize(width: -1, height: 1)
//        createCell.viewWrapper.layer.shadowRadius = 4
//        return createCell
//
//        //        }else {
//        //            joinCell.creatorName.text = orderObj.creatorName;
//        //            joinCell.restaurantName.text = orderObj.name;
//        //            joinCell.orderTime.text  = "\(orderObj.hr) : \(orderObj.min)";
//        //            joinCell.numOfPeople.text  = "\(orderObj.joinerCount) person(s)";
//        //            joinCell.deliveryFee.text  = "\(orderObj.dollar).\(orderObj.cent) $";
//        //            joinCell.selectionStyle = .none;
//        //            joinCell.viewWrapper.layer.borderColor = UIColor.lightGray.cgColor;
//        //            joinCell.viewWrapper.layer.borderWidth = 0.3;
//        //            joinCell.viewWrapper.layer.cornerRadius = 5;
//        //
//        //            joinCell.viewWrapper.layer.shadowColor = UIColor.lightGray.cgColor
//        //            joinCell.viewWrapper.layer.shadowOpacity = 0.8
//        //            joinCell.viewWrapper.layer.shadowOffset = CGSize(width: -1, height: 1)
//        //            joinCell.viewWrapper.layer.shadowRadius = 4
//        //            return joinCell
//        //        }
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 250.0
//    }
//}

    //
    //  feedController.swift
    //  cmu-share
    //
    //  Created by Bethany Huang on 10/14/18.
    //  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
    //
    
    import UIKit
    import Firebase
    
    class OrdersController: UIViewController, UITableViewDelegate, UITableViewDataSource, FeedCellDelegate {
        
        @IBOutlet weak var tableView: UITableView!
        var ref: DatabaseReference!
        var orderList = [Order]()
        var currentUId: String!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            ref = Database.database().reference()
            setCurrentUserId()
            loadOrders()
            // Do any additional setup after loading the view.
            
            let feedCellNib = UINib(nibName:"FeedTableViewCell", bundle: nil)
            tableView.register(feedCellNib, forCellReuseIdentifier: "feedCell")
        }
        
        func setCurrentUserId() {
            let user = Auth.auth().currentUser;
            currentUId = user!.uid
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
            print(sender, tappedIndexPath)
            
            self.performSegue(withIdentifier: "feedToJoinSegue", sender: nil)
        }
}
