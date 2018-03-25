//
//  ViewController.swift
//  APIDemo
//
//  Created by Chen Shih Chia on 2/8/18.
//  Copyright © 2018 ShihChia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func submit(_ sender: Any) {
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=da605fc8fb617a0856d0fdc48b57bdc9") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let urlContent = data {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            print(jsonResult)
                            print(jsonResult["name"])
                            
                            if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                DispatchQueue.main.sync(execute: {
                                    self.resultLabel.text = description
                                })
                                
                                
                            }
                        } catch {
                            print("Json Processing Failed")
                        }
                    }
                }
            }
            task.resume()
        } else {
            resultLabel.text = "Couldn't find the weather for that city, please try another"
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

