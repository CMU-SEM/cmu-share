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

    @IBOutlet weak var restaurantNameText: UITextField!
    @IBOutlet weak var menuText: UITextField!
    @IBOutlet weak var hourText: UITextField!
    @IBOutlet weak var minText: UITextField!
    @IBOutlet weak var dollarText: UITextField!
    @IBOutlet weak var centText: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var ref: DatabaseReference!
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "CreateToFeedSegue", sender: self)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        // check if any blank is empty
        if restaurantNameText.text == "" || menuText.text == "" || hourText.text == ""
            || minText.text == "" || dollarText.text == "" || centText.text == "" {
            let alert = UIAlertController(title: "Error", message: "All fields are Mandatory", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Congrats", message: "Order Created Successfully", preferredStyle: .alert)
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
                "creator_id" : creator_id!,
                "restaurantName" : restaurantNameText.text!,
                "detail" : menuText.text!,
                "hr" : Int(hourText.text!),
                "min" : Int(minText.text!),
                "dollar" : Int(dollarText.text!),
                "cent" : Int(centText.text!),
                "joiner_count" : 0
                ] as [String: Any]
            
            orderRef.setValue(orderObj) { (error, ref) in
                print("error")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantNameText.placeholder = "Restaurant Name"
        menuText.placeholder = "Your Menu"
        
        ref = Database.database().reference()
    }
}
