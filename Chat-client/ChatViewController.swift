//
//  ChatViewController.swift
//  Chat-client
//
//  Created by Xiomara on 10/27/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let query = PFQuery(className:"Message")
        query.findObjectsInBackground {
            (objects, error) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                
                self.messages = objects
                self.tableView.reloadData()
                
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                    }
                }
            } else {
                // Log details of the failure
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSendMessageButton(_ sender: AnyObject) {
        let newMessage = messageField.text
        
        let message = PFObject(className: "Messages")
        message["text"] = newMessage
        
        PFObject.saveAll(inBackground: [message]) { (succeeded, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(succeeded)
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messages != nil {
            return messages.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)

        cell.textLabel?.text = messages[indexPath.row]["text"] as! String?
        
        return cell
    }
    
}
