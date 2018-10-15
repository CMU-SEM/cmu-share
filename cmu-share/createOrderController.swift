//
//  createOrderController.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/14/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class createOrderController: UIViewController {

    @IBOutlet weak var restaurantNameText: UITextField!
    @IBOutlet weak var menuText: UITextField!
    @IBOutlet weak var hourText: UITextField!
    @IBOutlet weak var minText: UITextField!
    @IBOutlet weak var dollarText: UITextField!
    @IBOutlet weak var centText: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "CreateToFeedSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantNameText.placeholder = "Restaurant Name"
        menuText.placeholder = "Your Menu"
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
