//
//  profileController.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/9/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class profileController: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func signOutAction(_ sender: UIButton) {
        // sign off
        let firebaseAuth = Auth.auth()
        let user = firebaseAuth.currentUser?.uid;
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        // sign off successful
        self.performSegue(withIdentifier: "ProfileToSignInSegue", sender: self)
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
