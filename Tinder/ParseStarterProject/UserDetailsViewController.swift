//
//  UserDetailsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Chen Shih Chia on 3/5/18.
//  Copyright © 2018 Parse. All rights reserved.
//

import UIKit
import Parse

class UserDetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBAction func updateProfileImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var genderSwitch: UISwitch!
    
    @IBOutlet weak var interestedSwitch: UISwitch!
    
    @IBAction func update(_ sender: Any) {
        
        PFUser.current()?["isFemale"] = genderSwitch.isOn
        PFUser.current()?["isInterestedInWomen"] = interestedSwitch.isOn
        
        let imageData = UIImagePNGRepresentation(userImage.image!)
        PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageData!)
        PFUser.current()?.saveInBackground(block: { (success, error) in
           
            if error != nil {
                var displayErrorMsg = "Updated Failed - Please try again later"
                let error = error as NSError?
                if let errorMsg = error?.userInfo["error"] as? String {
                    displayErrorMsg = errorMsg
                }
                self.errorMsg.text = displayErrorMsg
                //self.createAlert(title: "Log In Error", msg: displayErrorMsg)
            } else {
                print("Updated")
                self.performSegue(withIdentifier: "showSwipingViewController", sender: self)
            }
        })
    }
    
    @IBOutlet weak var errorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the user's original profile
        if let isFemale = PFUser.current()?["isFemale"] as? Bool {
            genderSwitch.setOn(isFemale, animated: false)
        }
        
        if let isInterestedInWomen = PFUser.current()?["isInterestedInWomen"] as? Bool {
            interestedSwitch.setOn(isInterestedInWomen, animated: false)
        }
        
        if let photo = PFUser.current()?["photo"] as? PFFile {
            photo.getDataInBackground(block: { (data, error) in
                
                if let imageData = data {
                    if let downloadedImage = UIImage(data: imageData) {
                        self.userImage.image = downloadedImage
                    }
                }
            })
        }
        
        /* automatically sign up some new users
        let urlArray = ["https://media.npr.org/assets/img/2014/05/08/simp2006_homerarmscrossed_f_custom-ec94cc7a10463aa8260b2c5a9a3ebea29c7ecbfe-s900-c85.jpg", "https://vignette.wikia.nocookie.net/simpsons/images/1/12/Lisa_Simpson-0.png/revision/latest?cb=20161027220133", "https://images.wired.it/wp-content/uploads/2015/03/1426543355_I-Simpson-in-streetwear.jpg", "https://vignette.wikia.nocookie.net/simpsons/images/8/87/Marge_Simpson_2.png/revision/latest?cb=20150131104556", "https://i.pinimg.com/736x/01/73/ef/0173ef57d6b19fc006e97cb9b775b228--bart-simpson-going-away.jpg", "http://sayhey.files.wordpress.com/2007/04/homer-simpson-fat.gif", "https://vignette.wikia.nocookie.net/simpsons/images/0/0c/Abbie.png/revision/latest?cb=20130325071151", "https://upload.wikimedia.org/wikipedia/en/f/fc/The_Simpsons_-_The_13th_Season.jpg"]
        
        var counter = 0
        
        for urlString in urlArray {
            counter += 1
            let url = URL(string: urlString)!
            
            do {
                let data = try Data(contentsOf: url)
                let imageFile = PFFile(name: "photo.png", data: data)
                let user = PFUser()
                
                user["photo"] = imageFile
                user.username = String(counter)
                user.password = "password"
                user["isInterestedInWomen"] = false
                user["isFemale"] = false;
                
                let acl = PFACL()
                acl.getPublicWriteAccess = true
                user.acl = acl
                
                user.signUpInBackground(block: { (success, error) in
                    if success {
                        print("User signed up")
                    }
                })
            } catch {
                print("Can not get data")
            }
        }*/
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
