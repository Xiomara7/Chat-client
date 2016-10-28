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
        let chatController = ChatViewController(nibName: nil, bundle: nil)
        self.present(chatController, animated: true, completion: nil)
        
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
                let chatController = ChatViewController(nibName: nil, bundle: nil)
                self.present(chatController, animated: true, completion: nil)
            }
        }
    }
}
