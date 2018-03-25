//
//  ViewController.swift
//  SpinnerandAlerts
//
//  Created by Chen Shih Chia on 2/26/18.
//  Copyright © 2018 ShihChia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var activityIndicator = UIActivityIndicatorView()    // for the spinner
    
    @IBAction func createAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Hey there!", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            print("OK button pressed")
            self.dismiss(animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action) in
            print("NO button pressed")
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func pauseApp(_ sender: Any) {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()     //disable other buttons
    }
    
    @IBAction func restoreApp(_ sender: Any) {
        activityIndicator.stopAnimating()
        //UIApplication.shared.endIgnoringInteractionEvents()       //enable all the buttons
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

