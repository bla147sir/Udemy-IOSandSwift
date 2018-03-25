//
//  ViewController.swift
//  LogInDemo
//
//  Created by Chen Shih Chia on 2/6/18.
//  Copyright © 2018 ShihChia. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    var isLoggedIn = false
    @IBOutlet weak var logInButton: UIButton!
    @IBAction func logIn(_ sender: Any) {   // the database do not have any user name, so you enter a username and log in
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if isLoggedIn {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            do {
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        result.setValue(textField.text, forKey: "name")
                        do {
                            try context.save()
                        } catch {
                            print("Update username failed")
                        }
                    }
                    label.text = "Hi there " + textField.text! + "!"
                }
            } catch {
                print("Update username failed")
            }
        } else {
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            newValue.setValue(textField.text, forKey: "name")
            do {
                try context.save()
                logInButton.setTitle("Update username", for: [])
                logOutButton.alpha = 1
                label.alpha = 1
                label.text = "Hi there " + textField.text! + "!"
                isLoggedIn = true
            } catch {
                print("Failed to save")
            }
        }
        
    }
    
    @IBOutlet weak var logOutButton: UIButton!
    @IBAction func logOut(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    context.delete(result)
                    do {
                        try context.save()
                    } catch {
                        print("Individual delete failed")
                    }
                }
                label.alpha = 0
                logOutButton.alpha = 0
                logInButton.setTitle("Log In", for: [])
                isLoggedIn = false
            }
        } catch {
            print("Delete failed")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do {    // there are already some username in the database, so the app just automatically show the username on the screen
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject] {
                if let username = result.value(forKey: "name") as? String {
                    logInButton.setTitle("Update username", for: [])
                    logOutButton.alpha = 1
                    label.alpha = 1
                    label.text = "Hi there " + username + "!"
                    
                }
            }
        } catch {
            print("Request failed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

