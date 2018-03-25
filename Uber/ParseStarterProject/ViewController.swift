/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupMode = true;       // true = sign up mode; false = log in mode

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var riderDriverSwitch: UISwitch!
    
    @IBOutlet weak var riderlabel: UILabel!
    
    @IBOutlet weak var driverLabel: UILabel!
    
    @IBOutlet weak var signupOrLoginLabel: UIButton!
    
    @IBAction func signupOrLogin(_ sender: Any) {
        if username.text == "" || password.text == "" {
            createAlert(title: "Error in Form", msg: "Please enter an username or password")
        }
        else {
            if signupMode {
                riderDriverSwitch.isHidden = false
                riderlabel.isHidden = false
                driverLabel.isHidden = false
                
                let user = PFUser()
                user.username = username.text
                user.password = password.text
                user["isDriver"] = riderDriverSwitch.isOn
                
                user.signUpInBackground(block: { (success, error) in
                    
                    if error != nil {
                        var displayErrorMsg = "Sign Up Failed - Please try again later"
                        let error = error as NSError?
                        if let errorMsg = error?.userInfo["error"] as? String {
                            displayErrorMsg = errorMsg
                        }
                        self.createAlert(title: "Sign Up Error", msg: displayErrorMsg)
                    } else {
                        print("User signed up")
                        
                        if let isDriver = PFUser.current()?["isDriver"] as? Bool {
                            if isDriver {
                                self.performSegue(withIdentifier: "showDriverViewController", sender: self)
                            } else {
                                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
                            }
                            
                        }
                    }
                })
            }
            else {   // log in mode
                riderDriverSwitch.isHidden = true
                riderlabel.isHidden = true
                driverLabel.isHidden = true
                
                PFUser.logInWithUsername(inBackground: username.text!, password: password.text!, block: { (user, error) in
                    if error != nil {
                        var displayErrorMsg = "Login Failed - Please try againg later"
                        let error = error as NSError?
                        if let errorMsg = error?.userInfo["error"] as? String {
                            displayErrorMsg = errorMsg
                        }
                        self.createAlert(title: "Login Error", msg: displayErrorMsg)
                    } else {
                        print("User Logged in")
                        
                        if let isDriver = PFUser.current()?["isDriver"] as? Bool {
                            if isDriver {
                                self.performSegue(withIdentifier: "showDriverViewController", sender: self)
                            } else {
                                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
                            }
                            
                        }
                    }
                })
            }
        }
    }
    
    @IBOutlet weak var changeModeLabel: UIButton!
    
    @IBAction func changeMode(_ sender: Any) {
        
        if signupMode {
            signupOrLoginLabel.setTitle("Log In", for: [])
            changeModeLabel.setTitle("Switch to Sign Up", for: [])
            signupMode = false
            riderDriverSwitch.isHidden = true
            riderlabel.isHidden = true
            driverLabel.isHidden = true
        } else {
            signupOrLoginLabel.setTitle("Sign Up", for: [])
            changeModeLabel.setTitle("Switch to Log In", for: [])
            signupMode = true
            riderDriverSwitch.isHidden = false
            riderlabel.isHidden = false
            driverLabel.isHidden = false
        }
    }
    
    func createAlert(title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let isDriver = PFUser.current()?["isDriver"] as? Bool {
            if isDriver {
                self.performSegue(withIdentifier: "showDriverViewController", sender: self)
            } else {
                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
