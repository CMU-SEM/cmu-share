//
//  feedController.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/14/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class feedController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath) as! FeedTableViewCell;
        return cell;
    }
    

}
