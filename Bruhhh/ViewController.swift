//
//  ViewController.swift
//  Bruhhh
//
//  Created by Mac Demo on 1/26/16.
//  Copyright © 2016 Mac Demo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var bruhButton: UIButton!
    
    var loopPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("bruh-sound-effect", ofType: ".m4a")
        let url = NSURL(fileURLWithPath: path!)
        
        do {
            loopPlayer = try AVAudioPlayer(contentsOfURL: url)
            loopPlayer.prepareToPlay()
            loopPlayer.numberOfLoops = 0
        } catch {
            print("The sound could not be initialized")
        }
        
        bruhButton.layer.cornerRadius = 7.0
        //loopPlayer
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playBruh(sender: AnyObject) {
        
        loopPlayer.currentTime = 0
        loopPlayer.play()
        
    }

}

