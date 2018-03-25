//
//  SwipingViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Chen Shih Chia on 3/6/18.
//  Copyright © 2018 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipingViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var noMoreLabel: UILabel!
    
    var displayedUserID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noMoreLabel.isHidden = true
       
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecoginzer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
        
        PFGeoPoint.geoPointForCurrentLocation { (geopoint, error) in
            
            if let geopoint = geopoint {
                PFUser.current()?["location"] = geopoint
                PFUser.current()?.saveInBackground()
            }
        }
        
        updateImage()
    }
    
    func updateImage() {
        let query = PFUser.query()
        query?.whereKey("isFemale", equalTo: (PFUser.current()?["isInterestedInWomen"])!)
        query?.whereKey("isInterestedInWomen", equalTo: (PFUser.current()?["isFemale"])!)
        
        var ignoredUsers = [PFUser.current()?.objectId]
        
        if let acceptedUsers = PFUser.current()?["accepted"] {
            ignoredUsers += acceptedUsers as! Array
        }
        
        if let rejectedUsers = PFUser.current()?["rejected"] {
            ignoredUsers += rejectedUsers as! Array
        }
        query?.whereKey("objectId", notContainedIn: ignoredUsers)
        
        if let latitude = (PFUser.current()?["location"] as AnyObject).latitude {
            if let longitude = (PFUser.current()?["location"] as AnyObject).longitude {
                query?.whereKey("location", withinGeoBoxFromSouthwest: PFGeoPoint(latitude: latitude - 1, longitude: longitude - 1), toNortheast: PFGeoPoint(latitude: latitude + 1, longitude: longitude + 1))
            }
        }
        
        query?.limit = 1
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if objects?.count == 0 {
                self.noMoreLabel.isHidden = false
            } else {
                self.noMoreLabel.isHidden = true
            }
            
            if let users = objects {
                for object in users {
                    if let user = object as? PFUser {
                        self.displayedUserID = user.objectId!
                        let imageFile = user["photo"] as!PFFile
                        imageFile.getDataInBackground(block: { (data, error) in
                            if let imageData = data {
                                self.imageView.image = UIImage(data: imageData)
                            }
                        })
                    }
                 }
            }
            
        })
    }
    
    func wasDragged(gestureRecoginzer: UIPanGestureRecognizer) {
        let translation = gestureRecoginzer.translation(in: view)
        let image = gestureRecoginzer.view!
        
        image.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = image.center.x - self.view.bounds.width / 2
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        let scale = min(100 / abs(xFromCenter), 1)
        var strechAndRotation = rotation.scaledBy(x: scale, y: scale)
        
        image.transform = strechAndRotation
        
        if gestureRecoginzer.state == UIGestureRecognizerState.ended {
            var acceptedOrRejected = ""
            
            if image.center.x < 100 {
                print("Not chosen")
                acceptedOrRejected = "rejected"
            } else if image.center.x > self.view.bounds.width - 100 {
                print("Chosen")
                acceptedOrRejected = "accepted"
            }
            
            if acceptedOrRejected != "" && displayedUserID != ""{
                PFUser.current()?.addUniqueObjects(from: [displayedUserID], forKey: acceptedOrRejected)
                PFUser.current()?.saveInBackground(block: { (success, error) in
                    self.updateImage()
                })
            }
            
            rotation = CGAffineTransform(rotationAngle: 0)
            strechAndRotation = rotation.scaledBy(x: 1, y: 1)
            image.transform = strechAndRotation
            image.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue" {
            PFUser.logOut()
        }
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
