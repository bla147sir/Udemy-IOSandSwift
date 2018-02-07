//
//  ViewController.swift
//  Maps
//
//  Created by Chen Shih Chia on 1/29/18.
//  Copyright © 2018 ShihChia. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let latitude : CLLocationDegrees = 42.9504395
        let longtitude : CLLocationDegrees = -78.9025333
        let lanDelta : CLLocationDegrees = 0.05
        let longDelta : CLLocationDegrees = 0.05
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: longDelta)
        let coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "UB"
        annotation.subtitle = "I study here"
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
    }
    
    @objc func longpress(gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: self.map)
        let coordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "New place"
        annotation.subtitle = "Maybe I'll go here"
        map.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

