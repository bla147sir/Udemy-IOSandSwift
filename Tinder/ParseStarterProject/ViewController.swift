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
    
    var signupMode = true;   // true = signup mode; false = login mode

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signupOrLoginBut: UIButton!
    
    @IBAction func signupOrLogin(_ sender: Any) {
        
        if usernameTextField.text == "" || passwordTextField.text == "" {
            createAlert(title: "Error in form", msg: "Please enter an username or password")
        } else {
            if signupMode {
                let user = PFUser()
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                
                let acl = PFACL()
                acl.getPublicWriteAccess = true
                acl.getPublicReadAccess = true
                
                user.acl = acl
                
                user.signUpInBackground(block: { (success, error) in
                    
                    if (error != nil) {
                        var displayErrorMsg = "Sign Up Failed - Please try again later"
                        let error = error as NSError?
                        if let errorMsg = error?.userInfo["error"] as? String {
                            displayErrorMsg = errorMsg
                        }
                        self.errorLabel.text = displayErrorMsg
                        //self.createAlert(title: "Sign Up Error", msg: displayErrorMsg)
                    } else {
                        print("User Signed up")
                        self.performSegue(withIdentifier: "goToUserInfo", sender: self)
                    }
                })
            } else {
                // Log in mode
                PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    if error != nil {
                        var displayErrorMsg = "Log In Failed - Please try again later"
                        let error = error as NSError?
                        if let errorMsg = error?.userInfo["error"] as? String {
                            displayErrorMsg = errorMsg
                        }
                        self.errorLabel.text = displayErrorMsg
                        //self.createAlert(title: "Log In Error", msg: displayErrorMsg)
                    } else {
                        print("User Logged In")
                        self.redirectUser()
                    }
                })
            }
        }
    }
    
    @IBAction func changeMode(_ sender: Any) {
        if signupMode {
            // change to log in mode
            signupOrLoginBut.setTitle("Log In", for: [])
            changeModeBut.setTitle("Sign Up", for: [])
            msgLabel.text = "Don't have an account?"
            signupMode = false
        } else {
            // change to sign up mode
            signupOrLoginBut.setTitle("Sign Up", for: [])
            changeModeBut.setTitle("Log In", for: [])
            msgLabel.text = "Already have an account?"
            signupMode = true
        }
    }
    
    @IBOutlet weak var changeModeBut: UIButton!
    
    @IBOutlet weak var msgLabel: UILabel!
    
    func createAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        redirectUser()
    }
    
    func redirectUser() {
        if PFUser.current() != nil {
           // print(PFUser.current()?.objectId)
            if PFUser.current()?["isFemale"] != nil && PFUser.current()?["isInterestedInWomen"] != nil && PFUser.current()?["photo"] != nil{
                performSegue(withIdentifier: "swipeFromInitialSegue", sender: self)
            } else {
                performSegue(withIdentifier: "goToUserInfo", sender: self)
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
