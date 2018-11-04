//
//  createOrderController.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/14/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class createOrderController: UIViewController {

    var datePicker = UIDatePicker();
    @IBOutlet weak var restaurantNameText: UITextField!
    @IBOutlet weak var menuText: UITextField!
    @IBOutlet weak var hourText: UITextField!
    @IBOutlet weak var feeText: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var ref: DatabaseReference!
    var displayName: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        ref = Database.database().reference()
        updateDisplayName()
        setPlaceHolder()
        setKeyboardType()
        createDatePicker()
        StatusUpdateUtil.observeUpdate(_vc: self);
    }
    
    func setPlaceHolder() {
        restaurantNameText.placeholder = "* Restaurant Name"
        menuText.placeholder = "* Your Menu"
        hourText.placeholder = "* Hour"
        feeText.placeholder = "* Delivery Fee"
    }
    
    func setKeyboardType() {
        feeText.keyboardType = UIKeyboardType.decimalPad
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        // alert of progress loss
        let alert = UIAlertController(title: "Caution", message: "Your current progress may be lost.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            action in self.performSegue(withIdentifier: "CreateToFeedSegue", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        // check if any blank is empty
        if restaurantNameText.text == "" || menuText.text == ""  {
            let alert = UIAlertController(title: "Error", message: "Restaurant and Menu are required.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        // check if order time valid
        else if hourText.text == "" {
            let alert = UIAlertController(title: "Error", message: "Time Invalid", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        // check if delivery fee valid
        else if Double(feeText.text!) == nil {
            let alert = UIAlertController(title: "Error", message: "Delivery Fee Invalid", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Congrats", message: "Order created successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                action in self.performSegue(withIdentifier: "CreateToFeedSegue", sender: self)}))
            self.present(alert, animated: true, completion: nil)
            
            // create a new order in the system
            let orderRef = Database.database().reference().child("orders").childByAutoId();
            // get creator uid
            let user = Auth.auth().currentUser
            let creator_id = user?.uid
            
            // create order profile

            let orderObj = [
                "orderId": orderRef.key!,
                "creator_id" : creator_id!,
                "creatorName" : displayName!,
                "restaurantName" : restaurantNameText.text!,
                "detail" : menuText.text!,
                "hr" : datePicker.calendar.component(.hour, from: datePicker.date),
                "min" : datePicker.calendar.component(.minute, from: datePicker.date),
                "fee" : Double(feeText.text!)!,
                "joiner_count" : 0,
                "status" : Order.STATUS_OPEN,
                "place" : "N/A"
                ] as [String: Any]
            
            orderRef.setValue(orderObj) { (error, ref) in
                print("error")
            }
        }
    }
    
    func updateDisplayName() {
        let user = Auth.auth().currentUser
        let creator_id = user!.uid
        
        ref.child("users").child(creator_id).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.displayName = value?["firstName"] as? String ?? ""
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func createDatePicker() {
        datePicker.datePickerMode = .time;
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit();
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneac))
        toolbar.setItems([doneBtn], animated: true)
        hourText.inputAccessoryView = toolbar
        
        hourText.inputView = datePicker
    }
    
    @objc func doneac() {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        hourText.text = "\(dateFormatterGet.string(from: datePicker.date))"
        self.view.endEditing(true);
    }
}
