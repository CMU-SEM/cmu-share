//
//  OrdersController.swift
//  cmu-share
//
//  Created by Sathish on 10/19/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class OrdersController: UIViewController {

    @IBOutlet weak var createOrder: UIView!
    @IBOutlet weak var joinedOrder: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            createOrder.alpha = 0
            joinedOrder.alpha = 1
        }
        else {
            createOrder.alpha = 1
            joinedOrder.alpha = 0
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
