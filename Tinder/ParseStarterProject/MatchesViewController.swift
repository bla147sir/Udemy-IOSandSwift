//
//  MatchesViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Chen Shih Chia on 3/7/18.
//  Copyright © 2018 Parse. All rights reserved.
//

import UIKit
import Parse

class MatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var images = [UIImage]()
    var userIds = [String]()
    var messages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let query = PFUser.query()
        query?.whereKey("accepted", contains: PFUser.current()?.objectId)
        query?.whereKey("objectId", containedIn: PFUser.current()?["accepted"] as! [String])
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects {
                for object in users {
                    if let user = object as? PFUser {
                        let imageFile = user["photo"] as! PFFile
                        imageFile.getDataInBackground(block: { (data, error) in
                            
                            if let imageData = data {
                                
                                let messageQuery = PFQuery(className: "Message")
                                messageQuery.whereKey("recipient", equalTo: (PFUser.current()?.objectId!)!)
                                messageQuery.whereKey("sender", equalTo: user.objectId!)
                                
                                messageQuery.findObjectsInBackground(block: { (objects, error) in
                                    
                                    var msgText = "No message for this user"
                                    if let objects = objects {
                                        for message in objects {
                                            if let messageContent = message["content"] as? String {
                                                msgText = messageContent
                                            }
                                            
                                        }
                                    }
                                    self.messages.append(msgText)
                                    self.images.append(UIImage(data: imageData)!)
                                    self.userIds.append(user.objectId!)
                                    self.tableView.reloadData()
                                })
                            }
                        })
                    }
                }
            }
        })

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MatchesTableViewCell
        
        cell.matchImageView.image = images[indexPath.row]
        cell.msgLabel.text = "You haven't received a message yet"
        cell.userIdLabel.text = userIds[indexPath.row]
        cell.msgLabel.text = messages[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
