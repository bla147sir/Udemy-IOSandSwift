//
//  DetailViewController.swift
//  BlogReader
//
//  Created by Chen Shih Chia on 2/18/18.
//  Copyright © 2018 ShihChia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var webView: UIWebView!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            self.title = detail.value(forKey:"title") as! String
            if let blogWebView = self.webView {
                blogWebView.loadHTMLString(detail.value(forKey:"content") as! String, baseURL: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Event? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

