//
//  LoginViewController.swift
//  Chat-client
//
//  Created by Xiomara on 10/27/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        PFUser.logInWithUsername(inBackground: emailField.text!, password: passwordField.text!) {
            (user, error) in
            if user != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let chatController = storyboard.instantiateViewController(withIdentifier: "chatController")
                self.present(chatController, animated: true, completion: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    @IBAction func onSignUpButton(_ sender: AnyObject) {
        let user = PFUser()
        user.email = emailField.text
        user.username = emailField.text
        user.password = passwordField.text
        
        user.signUpInBackground {(succeeded, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("success")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let chatController = storyboard.instantiateViewController(withIdentifier: "chatController")
                self.present(chatController, animated: true, completion: nil)
            }
        }
    }
}
