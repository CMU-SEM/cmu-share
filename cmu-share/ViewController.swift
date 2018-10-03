//
//  ViewController.swift
//  cmu-share
//
//  Created by Pattarasai Markpeng on 10/1/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func logInAction(_ sender: UIButton) {
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                if user != nil {
                    // sign in successful
            self.performSegue(withIdentifier: "segue", sender: self)
                    print("successful")
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
    
    @IBAction func signUpAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailText.placeholder = "Email";
        passwordText.placeholder = "Password";
    }


}

