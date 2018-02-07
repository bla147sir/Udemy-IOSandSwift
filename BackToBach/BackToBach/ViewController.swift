//
//  ViewController.swift
//  BackToBach
//
//  Created by Chen Shih Chia on 2/4/18.
//  Copyright © 2018 ShihChia. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVAudioPlayer()
    let audioPath = Bundle.main.path(forResource: "sheep", ofType: ".mp3")
    var timer = Timer()
    
    @objc func updateScrubber() {
        scrubberSlider.value = Float(player.currentTime)
    }
    @IBAction func play(_ sender: Any) {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
    }
    
    @IBAction func volumeChanged(_ sender: Any) {
        player.volume = volumeSlider.value
    }
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBAction func scrubberMoved(_ sender: Any) {
        player.currentTime = TimeInterval(scrubberSlider.value)
    }
    @IBOutlet weak var scrubberSlider: UISlider!
    
    @IBAction func pause(_ sender: Any) {
        player.pause()
        timer.invalidate()
    }
    
    @IBAction func stop(_ sender: Any) {
        timer.invalidate()
        player.pause()
        // start at zero
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch {
            // process error
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            scrubberSlider.maximumValue = Float(player.duration)
        } catch {
            // process error
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

