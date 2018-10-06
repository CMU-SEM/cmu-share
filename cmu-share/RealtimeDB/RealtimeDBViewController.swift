//
//  RealtimeDBViewController.swift
//  cmu-share
//
//  Created by Pattarasai Markpeng on 10/6/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class RealtimeDBViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var detailLabel: UITextField!
    
    
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addRestaurant(_ sender: Any) {
        let orderRef = Database.database().reference().child("orders").childByAutoId();
        
        let orderObj = [
            "restaurantName" : nameLabel.text,
            "detail": detailLabel.text,
            "timestamp": [".sv", "timestamp"]
        ] as [String: Any]
        
        orderRef.setValue(orderObj) { (error, ref) in
            print("error")
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
