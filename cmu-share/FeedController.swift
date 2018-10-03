//
//  ViewController2.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/3/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class FeedController: UIViewController {

    @IBAction func signOffAction(_ sender: UIButton) {
        // sign off
        let firebaseAuth = Auth.auth()
        let user = firebaseAuth.currentUser?.uid;
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        // sign off successful
        self.performSegue(withIdentifier: "logInSegue", sender: self)
    }
    @IBOutlet weak var signOffButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

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
