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

    @IBOutlet weak var foodItemName1: UITextField!
    @IBOutlet weak var quantity1: UITextField!
    @IBOutlet weak var size1: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var ref: DatabaseReference!
    var displayName: String!
    var orderId: String! // order id to be joined
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "joinToFeedSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
