//
//  MatchesTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Chen Shih Chia on 3/7/18.
//  Copyright © 2018 Parse. All rights reserved.
//

import UIKit
import Parse

class MatchesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var matchImageView: UIImageView!
    
    @IBOutlet weak var msgLabel: UILabel!
    
    @IBOutlet weak var msgTextField: UITextField!
    
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBAction func send(_ sender: Any) {
        print(userIdLabel.text)
        print(msgLabel.text)
        
        let message = PFObject(className: "Message")
        message["sender"] = PFUser.current()?.objectId!
        message["recipient"] = userIdLabel.text
        message["content"] = msgTextField.text
        message.saveInBackground()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
