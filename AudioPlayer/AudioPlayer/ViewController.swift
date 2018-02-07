//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Chen Shih Chia on 2/4/18.
//  Copyright © 2018 ShihChia. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVAudioPlayer()
    
    @IBAction func play(_ sender: AnyObject) {
        player.play()
    }
    
    @IBAction func pause(_ sender: AnyObject) {
        player.pause()
    }
    
    @IBAction func sliderMoved(_ sender: AnyObject) {
        player.volume = slider.value
    }
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let audioPath = Bundle.main.path(forResource: "sheep", ofType: ".mp3")
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))

        } catch {
            // Process any error
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

