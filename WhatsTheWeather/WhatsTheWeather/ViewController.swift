//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by Chen Shih Chia on 10/19/17.
//  Copyright © 2017 ShihChia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var resultLab: UILabel!
    
    @IBAction func submitBut(_ sender: Any) {
        if let url = URL(string :"https://www.weather-forecast.com/locations/"+cityTextField.text!.replacingOccurrences(of: " ", with: "-")+"/forecasts/latest") {
            let request = NSMutableURLRequest(url : url)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, reponse, error in
                var message = ""
                if error != nil {
                    print(error)
                } else {
                    if let unwrappedData = data {
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                            if contentArray.count > 1 {
                                stringSeparator = "</span>"
                                let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                if newContentArray.count > 1 {
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    print(message)
                                }
                                
                            }
                        }
                    }
                }
                if message == "" {
                    message = "The weather there couldn't be found. Please try again."
                }
                DispatchQueue.main.sync(execute: {
                    self.resultLab.text = message
                })
            }
            task.resume()
        } else {
            resultLab.text = "The weather there couldn't be found. Please try again."
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

