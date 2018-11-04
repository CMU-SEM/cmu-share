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

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    
    @IBOutlet weak var signOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var ref: DatabaseReference!
        ref = Database.database().reference();
        
        let user = Auth.auth().currentUser
        let creator_id = user!.uid
        
        ref.child("users").child(creator_id).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user profile info
            let profile = snapshot.value as! [String: AnyObject]
            let firstName = profile["firstName"]
            let lastName = profile["lastName"]
            let email = profile["email"]
            let phoneNumber = profile["phoneNumber"]
            self.firstName.text = firstName as? String
            self.lastName.text = lastName as? String
            self.email.text = email as? String
            self.phoneNumber.text = phoneNumber as? String
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
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
