//
//  signUpController.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/3/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class signUpController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var mobileText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    var ref: DatabaseReference!
    
    @IBAction func logInAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToSignInSegue", sender: self)
    }
    @IBAction func signUpAction(_ sender: UIButton) {
        // check if any blank is empty
        if emailText.text == "" || passwordText.text == "" || confirmPasswordText.text == ""
            || firstNameText.text == "" || lastNameText.text == "" || mobileText.text == "" {
            let alert = UIAlertController(title: "Error", message: "Mandatory fields are required", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        // check if cmu email
        else if emailText.text?.suffix(15) != "@andrew.cmu.edu" {
            let alert = UIAlertController(title: "Error", message: "The email should be an Andrew email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        // check if password valid
        else if (passwordText.text?.count)! < 6 {
            let alert = UIAlertController(title: "Error", message: "Password has to be more than 6 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        // check if confirm password valid
        else if confirmPasswordText.text != passwordText.text {
            let alert = UIAlertController(title: "Error", message: "Confirm Password does not match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        // check if telephone number valid
        else if mobileText.text!.count != 10 {
            let alert = UIAlertController(title: "Error", message: "Phone number is invlaid", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authResult, error) in
                if authResult != nil {
                    // sign up successful
                    let alert = UIAlertController(title: "Congrats", message: "Sign up is complete! Now you can Sign In.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                        action in self.performSegue(withIdentifier: "backToSignInSegue", sender: self)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    // create a new user in the system
                    let user = Auth.auth().currentUser
                    let id = user?.uid
                    
                    let userRef = Database.database().reference().child("users").child(id!);
    
                    let userObj = [
                        "email" : self.emailText.text!,
                        "firstName": self.firstNameText.text!,
                        "lastName": self.lastNameText.text!,
                        "phoneNumber": self.mobileText.text!,
                        "uid": id!
                        ] as [String: Any]

                    userRef.setValue(userObj) { (error, ref) in
                        print("error")
                    }
                }
                else {
                    let alert = UIAlertController(title: "Error", message: "This email is already used!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailText.placeholder = "* Email";
        passwordText.placeholder = "* Password";
        confirmPasswordText.placeholder = "* Confirm Password"
        firstNameText.placeholder = "* First Name"
        lastNameText.placeholder = "* Last Name"
        mobileText.placeholder = "* Mobile No."

        ref = Database.database().reference()
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
