//
//  ViewController.swift
//  SoundShaker
//
//  Created by Chen Shih Chia on 2/5/18.
//  Copyright © 2018 ShihChia. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake {
            let soundArray = ["boing", "swish", "shoot", "knife", "wah", "explosion", "hit", "warble"]
            let randomNumber = Int(arc4random_uniform(UInt32(soundArray.count)))
            let fileLocation = Bundle.main.path(forResource: soundArray[randomNumber], ofType: ".mp3")
            
            do {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileLocation!))
                player.play()
            } catch {
                // process error
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

