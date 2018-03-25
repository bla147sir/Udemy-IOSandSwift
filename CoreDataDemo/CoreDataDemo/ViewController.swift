//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Chen Shih Chia on 2/6/18.
//  Copyright © 2018 ShihChia. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue("Tara", forKey: "username")
        newUser.setValue("myPassword", forKey: "password")
        newUser.setValue(24, forKey: "age")
        
        do {
            try context.save()
            print("Saved")
        } catch {
            print("There was an error")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "username = %@", "Tara") // return the username called Tara only
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let username = result.value(forKey: "username") as? String {
                        print(username)
                    }
                }
            } else {
                print("No result")
            }
        } catch {
            print("Couldn't fetch result")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

