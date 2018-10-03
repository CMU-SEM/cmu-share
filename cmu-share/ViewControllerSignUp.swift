//
//  ViewControllerSignUp.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/3/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerSignUp: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var mobileText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func logInAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToSignInSegue", sender: self)
    }
    @IBAction func signUpAction(_ sender: UIButton) {
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authResult, error) in
                if authResult != nil {
                    // sign up successful
                    self.performSegue(withIdentifier: "backToSignInSegue", sender: self)
                }
                else {
                    if let myError = error?.localizedDescription {
                        print(myError)
                    }else{
                        print("ERROR")
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailText.placeholder = "Email";
        passwordText.placeholder = "Password";
        confirmPasswordText.placeholder = "Confirm Password"
        firstNameText.placeholder = "First Name"
        lastNameText.placeholder = "Last Name"
        mobileText.placeholder = "Mobile No."
        
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
