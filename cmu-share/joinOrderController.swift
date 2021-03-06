//
//  joinOrderController.swift
//  cmu-share
//
//  Created by Anup Ahuje on 10/18/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class joinOrderController: UIViewController {

    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var foodItemName1: UITextField!
    @IBOutlet weak var quantity1: UITextField!
    @IBOutlet weak var size1: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    @IBOutlet weak var secondViewWrapper: UIView!
    @IBOutlet weak var foodItemName2: UITextField!
    @IBOutlet weak var quantity2: UITextField!
    @IBOutlet weak var size2: UITextField!
    
    @IBOutlet weak var addMoreBtn: UIButton!
    
    var ref: DatabaseReference!
    var userInformation: User!
    var orderId: String! // order id to be joined
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        // alert of progress loss
        let alert = UIAlertController(title: "Caution", message: "Your current progress may be lost.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            action in self.performSegue(withIdentifier: "joinToFeedSegue", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
       self.hideKeyboardWhenTappedAround()
       ref = Database.database().reference();
       initializeViewStyle()
       getUserInformation()
       setPlaceHolder()
       setKeyboard()
       StatusUpdateUtil.observeUpdate(_vc: self);
    }
    
    
    func setKeyboard() {
        quantity1.keyboardType = .decimalPad
        quantity2.keyboardType = .decimalPad
    }
    
    func setPlaceHolder() {
        foodItemName1.placeholder = "Required"
        foodItemName2.placeholder = "Required"
        quantity1.placeholder = "Required"
        quantity2.placeholder = "Required"
        size1.placeholder = "Required"
        size2.placeholder = "Required"
    }
    
    func initializeViewStyle() {
        self.foodItemName1.placeholder = "Food Item 1";
        self.foodItemName2.placeholder = "Food Item 2";
        styleViewWrapper(viewWrapper: self.viewWrapper);
        styleViewWrapper(viewWrapper: self.secondViewWrapper);
        self.secondViewWrapper.isHidden = true;
    }
    @IBAction func onClickAddMoreItem(_ sender: Any) {
        self.secondViewWrapper.isHidden = false;
        self.addMoreBtn.isEnabled = false;
        self.addMoreBtn.backgroundColor = UIColor.lightGray;
        self.addMoreBtn.titleLabel!.textColor = UIColor.white;
    }
    
    func styleViewWrapper(viewWrapper: UIView) {
        viewWrapper.layer.borderColor = UIColor.lightGray.cgColor;
        viewWrapper.layer.borderWidth = 0.3;
        viewWrapper.layer.cornerRadius = 5;
        
        viewWrapper.layer.shadowColor = UIColor.lightGray.cgColor
        viewWrapper.layer.shadowOpacity = 0.8
        viewWrapper.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewWrapper.layer.shadowRadius = 4
    }
    
    @IBAction func onClickJoin(_ sender: Any) {
        if(validate()) {
            let joinOrderUid = createJoinOrderInFirebase();
            verifyStatusAndUpdatePersonCount(joinOrderUid: joinOrderUid);
            let alert = UIAlertController(title: "Success", message: "Order Joined Successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                self.performSegue(withIdentifier: "joinToFeedSegue", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func validate()-> Bool{
        let foodItem1Val = foodItemName1.text!;
        let foodItem2Val = foodItemName2.text!;
        let quantity1Val = self.quantity1.text!;
        let quantity2Val = self.quantity2.text!;
        let size1Val = self.size1.text!;
        let size2Val = self.size2.text!;
        
        // check if any field empty
        if(foodItem1Val == "" || quantity1Val == "" || size1Val == "") || (!addMoreBtn.isEnabled && (foodItem2Val == "" || quantity2Val == "" || size2Val == "")) {
            let alert = UIAlertController(title: "Error", message: "Mandatory fields are required", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false;
        }
        // check if quantity valid
        else if Int(quantity1Val) == nil || (!addMoreBtn.isEnabled && (Int(quantity2Val)) == nil) {
            let alert = UIAlertController(title: "Error", message: "Quantity Invalid", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        return true;
    }
    
    func createJoinOrderInFirebase() -> String {
        let joinOrderRef = ref.child("joinOrder").childByAutoId();
        let uid = joinOrderRef.key!;
        let joinerId = userInformation.uid;
        let joinerDisplayName = userInformation.firstName;
        let phone = userInformation.phoneNumber;
        let foodItem1Val = foodItemName1.text!;
        let foodItem2Val = foodItemName2.text!;
        let quantity1Val = self.quantity1.text!;
        let quantity2Val = self.quantity2.text!;
        let size1Val = self.size1.text!;
        let size2Val = self.size2.text!;
        
        let joinOrder = JoinOrder(uid: uid, orderId: orderId, joinerId: joinerId, joinerDisplayName: joinerDisplayName, foodItem1: foodItem1Val, quantity1: quantity1Val, size1: size1Val, foodItem2: foodItem2Val, quantity2: quantity2Val, size2: size2Val, phone: phone);
        
        joinOrderRef.setValue(joinOrder.toDataDict()) { (error, ref) in
            print(error)
        }
        return uid;
    }
    
    func verifyStatusAndUpdatePersonCount(joinOrderUid: String) {
        ref.child("orders").child(orderId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as! [String: AnyObject]
            let order = Order(dict:value, uid: self.orderId)
            
            if(order.status != "open") {
                let alert = UIAlertController(title: "Success", message: "This order is closed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                    
                    self.ref.child("joinOrder").child(joinOrderUid).removeValue();
                    self.performSegue(withIdentifier: "joinToFeedSegue", sender: self)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.ref.child("orders").child(self.orderId).updateChildValues(["joiner_count": (order.joinerCount+1)]);
            }
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    func getUserInformation() {
        let user = Auth.auth().currentUser
        let creator_id = user!.uid
        
        ref.child("users").child(creator_id).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as! [String: AnyObject]
            self.userInformation = User(dict:value, uid: creator_id);
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
