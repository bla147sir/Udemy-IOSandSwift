//
//  ViewController.swift
//  DownloadingImagesFromTheWeb
//
//  Created by Chen Shih Chia on 2/8/18.
//  Copyright © 2018 ShihChia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bachImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // This is step 2: we show the image downloaded online to prove we do save the image on our phone
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        if documentsPath.count > 0 {
            let documentsDirectory = documentsPath[0]
            let restorePath = documentsDirectory + "/bach.jpg"
            bachImageView.image = UIImage(contentsOfFile: restorePath)
            
        }
        
        
        /*
         // The following is step 1: find the image from the url, and then download and save it.
         // Go to above
 
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")!
        let request = NSMutableURLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print(error!)
            } else {
                if let data = data {
                    if let bachImage = UIImage(data: data) {
                        self.bachImageView.image = bachImage
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                        
                        if documentsPath.count > 0 {
                            let documentsDirectory = documentsPath[0]
                            let savePath = documentsDirectory + "/bach.jpg"
                            do {
                                try UIImageJPEGRepresentation(bachImage, 1)?.write(to: URL(fileURLWithPath: savePath))   // 1: best quality
                            } catch {
                                // process error
                            }
                        }
                    }
                }
            }
        }
        task.resume()
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

