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
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let titleDict = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        
        let buttonImage = UIImage(named: "System-settings-icon")
        let menuButtonImage = UIImage(named: "menu-icon")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: buttonImage, style: .Plain, target: self, action: "showSettings")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage, style: .Plain, target: self, action: "showButtons")
        
        bruhButton.layer.cornerRadius = 100.0
        bruhButton.layer.borderColor = UIColor.grayColor().CGColor
        bruhButton.layer.borderWidth = 3.0
        bruhButton.clipsToBounds = true
        //loopPlayer
        
    }
    
    override func viewWillAppear(animated: Bool) {
        createLoopPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playBruh(sender: AnyObject) {
        loopPlayer.currentTime = 0
        loopPlayer.play()
        
    }
    
    func createLoopPlayer() {
        let path = NSBundle.mainBundle().pathForResource("bruh-sound-effect", ofType: ".m4a")
        let url = NSURL(fileURLWithPath: path!)
        
        do {
            loopPlayer = try AVAudioPlayer(contentsOfURL: url)
            loopPlayer.prepareToPlay()
            loopPlayer.numberOfLoops = 0
        } catch {
            print("The sound could not be initialized")
        }
    }
    
    func showSettings() {
        print("Showing settings")
        
        let settingsVC = SettingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func showButtons() {
        print("Show button selection")
        
        let 👍🏼 = ButtonSelectionViewController()
        👍🏼.titleString = "Choose a button"
        let 💩 = UINavigationController(rootViewController: 👍🏼)
        self.navigationController?.presentViewController(💩, animated: true, completion: nil)
    }

}

