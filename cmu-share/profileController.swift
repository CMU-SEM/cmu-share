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

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UITextField!
    var ref: DatabaseReference!
    var currentUId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround();
        StatusUpdateUtil.observeUpdate(_vc: self)
        ref = Database.database().reference()
        setCurrentUserId()
        
        ref.child("users").child(currentUId).observeSingleEvent(of: .value, with: { (snapshot) in
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

        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func setCurrentUserId() {
        let user = Auth.auth().currentUser;
        currentUId = user!.uid;
    }
    @IBAction func updateAction(_ sender: Any) {
        ref.child("users").child(currentUId).updateChildValues(["phoneNumber": phoneNumber.text!,
                                                                "firstName" : firstName.text!,
                                                                "lastName" : lastName.text!])
        // update successful
        let alert = UIAlertController(title: "Congrats", message: "Update is Complete!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func signOutAction(_ sender: UIButton) {
        // sign off
        let firebaseAuth = Auth.auth()
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
