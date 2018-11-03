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
    var order: Order!
    var selectedStatus: String?
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var numJoinerLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusField: UITextField!
    @IBOutlet weak var placeField: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    let status = ["Processing",
                  "On The Way",
                  "Delivered"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        setCurrentUserId()
        loadOrders()
        createStatusPicker()
        createToolbar()
        
        let detailCellNib = UINib(nibName:"DetailTableViewCell", bundle: nil)
        tableView.register(detailCellNib, forCellReuseIdentifier: "detailCell")
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(OrderDetailController.dismissKeyboard))
        
        // change color
        toolBar.barTintColor = .white
        toolBar.tintColor = .red
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        statusField.inputAccessoryView = toolBar
    }
    
  
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    @IBAction func cancelAction(_ sender: Any) {
        // alert of progress loss
        let alert = UIAlertController(title: "Caution", message: "Your Current Progress May Be Lost.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            action in self.performSegue(withIdentifier: "detailToOrderSegue", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        // check if any blank is empty
        if statusField.text == "Closed" {
            let alert = UIAlertController(title: "Error", message: "Current Status is Required", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if statusField.text == "Delivered" && (placeField.text == "N/A" || placeField.text == "") {
            let alert = UIAlertController(title: "Error", message: "Place of Pickup Required", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            if statusField.text == "open" {
                // success message
                let alert = UIAlertController(title: "Congrats", message: "Order Closed Successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                    action in self.performSegue(withIdentifier: "detailToOrderSegue", sender: self)}))
                self.present(alert, animated: true, completion: nil)
                
                ref.child("orders").child(orderId).updateChildValues(["status": "Closed"])
            }else{
                // success message
                let alert = UIAlertController(title: "Congrats", message: "Order Updated Successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                    action in self.performSegue(withIdentifier: "detailToOrderSegue", sender: self)}))
                self.present(alert, animated: true, completion: nil)
                
                // update order status and place
                if (order.status != "Delivered") {
                    ref.child("orders").child(orderId).updateChildValues(["status": statusField.text!])
                }else{
                    ref.child("orders").child(orderId).updateChildValues(["status": statusField.text!,
                                                                          "place" : placeField.text!])
                }
            }
        }
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
                    let cur_order = Order(dict: item as! [String : AnyObject], uid: uid)
                    if (self.currentUId != nil && cur_order.uid == self.orderId) {
                        self.order = cur_order
                        self.restaurantNameLabel.text = self.order.name
                        self.orderTimeLabel.text = "\(self.order.hr) : \(self.order.min)"
                        self.numJoinerLabel.text = String(self.order.joinerCount)
                        self.feeLabel.text = String(self.order.fee)
                        // set current value in textfield
                        self.statusField.text = self.order.status
                        self.placeField.text = self.order.place
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
        
        cell.joinerName.text = "\(joinerObj.joinerDisplayName)"
        cell.foodItem1.text = "\(joinerObj.foodItem1)"
        cell.quantity1.text = "\(joinerObj.quantity1)"
        cell.size1.text = "\(joinerObj.size1)"
        
        if(joinerObj.foodItem2 != "") {
            cell.viewWrapper.isHidden = false;
            cell.foodItem2.text =  joinerObj.foodItem2;
            cell.quantity2.text = joinerObj.quantity2;
            cell.size2.text = joinerObj.size2;
        } else {
            cell.viewWrapper.isHidden = true;
        }
        cell.selectionStyle = .none;
        
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let joinerObj = self.joinOrderList[indexPath.row] as JoinOrder
        if(joinerObj.foodItem2 != "") {
            return 113.5
        }else {
            return 75
        }
    }
    
    func createStatusPicker() {
        let statusPicker = UIPickerView()
        statusPicker.delegate = self
        
        statusField.inputView = statusPicker
    }
}

extension OrderDetailController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return status.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return status[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedStatus = status[row]
        statusField.text = selectedStatus
    }
}
