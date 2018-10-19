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
    @IBOutlet weak var foodItemName2: UITextField!
    @IBOutlet weak var quantity2: UITextField!
    @IBOutlet weak var size2: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var ref: DatabaseReference!
    var displayName: String!
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "joinToFeedSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodItemName1.placeholder = "Food Item 1"
        foodItemName2.placeholder = "Food Item 2"

        // Do any additional setup after loading the view.
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
