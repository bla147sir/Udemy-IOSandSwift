//
//  ViewController.swift
//  SwipeDemo
//
//  Created by Chen Shih Chia on 3/4/18.
//  Copyright © 2018 ShihChia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel(frame: CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 50, width: 200, height: 100))
        
        label.text = "Drag me!"
        label.textAlignment = NSTextAlignment.center
        view.addSubview(label)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecognizer:)))
        
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(gesture)
    }
    
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        let label = gestureRecognizer.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2    // distance between the middle to the current dragging position
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)      // make the label rotate when dragging it to left or right
        let scale = min(100 / abs(xFromCenter), 1)     // how small will the label be
        var strechAndRotation = rotation.scaledBy(x: scale, y: scale)     // make the label smaller when dragging it to left or right

        label.transform = strechAndRotation
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            if label.center.x < 100 {
                print("Not Chosen")
            } else if label.center.x > self.view.bounds.width - 100{
                print("Chosen")
            }
            
            rotation = CGAffineTransform(rotationAngle: 0)    // reset to original rotation degree
            strechAndRotation = rotation.scaledBy(x: 1, y: 1)   // reset to original size
            label.transform = strechAndRotation
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)   // reset to the middle
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

