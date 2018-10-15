//
//  feedController.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/14/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class feedController: UIViewController {
    @IBOutlet weak var createButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func prototypeAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "FeedToPrototypeSegue", sender: self)
    }
    @IBAction func createAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "FeedToCreateSegue", sender: self)
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
