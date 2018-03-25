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

    var signupMode = true
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    func createAlers(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func signupOrLogin(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            createAlers(title: "Error in form", message: "Please enter an email and password")
        } else {
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            if signupMode {
                // Sign up
                let user = PFUser()
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                user.signUpInBackground(block: { (success, error) in
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        var displayerrorMsg = "Please try again later."
                        let error = error as NSError?
                        if let errorMsg = error?.userInfo["error"] as? String {
                            displayerrorMsg = errorMsg
                        }
                        self.createAlers(title: "Sign Up Error", message: displayerrorMsg)
                    } else {
                        print("user signed up")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                })
                
            } else {
                // Log in mode
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    if error != nil {
                        var displayerrorMsg = "Please try again later."
                        let error = error as NSError?
                        if let errorMsg = error?.userInfo["error"] as? String {
                            displayerrorMsg = errorMsg
                        }
                        self.createAlers(title: "Log In Error", message: displayerrorMsg)
                    } else {
                        print("Logged In")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                })
            }
        }
    }
    
    @IBOutlet weak var signupOrLogin: UIButton!
    
    @IBAction func changeSignupMode(_ sender: Any) {
        if signupMode {
            // change to log in mode
            signupOrLogin.setTitle("Log In", for: [])
            signupModeButton.setTitle("Sign Up", for: [])
            messageLabel.text = "Don't have an account?"
            signupMode = false
        } else {
            // change to sign up mode
            signupOrLogin.setTitle("Sign Up", for: [])
            signupModeButton.setTitle("Log In", for: [])
            messageLabel.text = "Already have an account?"
            signupMode = true;
        }
    }
    
    @IBOutlet weak var signupModeButton: UIButton!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            performSegue(withIdentifier: "showUserTable", sender: self)
        }
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        // insert new class
        let user = PFObject(className: "Users")
        user["name"] = "Tara"
        user.saveInBackground { (success, error) in
            if success {
                print("Object saved")
            } else {
                if let error = error {
                    print(error)
                } else {
                    print("Error")
                }
            }
        }
        // update the object on parse
        let query = PFQuery(className: "Users")
        query.getObjectInBackground(withId:"ddie6hL9X1") { (object, error) in
            if error != nil {
                print(error)
            } else {
                if let user = object {
                    user["name"] = "Chen"
                    user.saveInBackground(block: { (success, error) in
                        if success {
                            print("Saved")
                        } else {
                            print(error)
                        }
                    })
                }
            }
        } */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
