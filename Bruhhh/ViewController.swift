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
    var currentButton = [String: AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().boolForKey("UseDefault") {
            currentButton = NSUserDefaults.standardUserDefaults().dictionaryForKey("DefaultButton")!
            NSUserDefaults.standardUserDefaults().setObject(currentButton, forKey: "LastButtonUsed")
            print("Current button: \(currentButton)")
        } else {
            currentButton = NSUserDefaults.standardUserDefaults().dictionaryForKey("LastButtonUsed")!
            print("Last used button: \(currentButton)")
        }
        
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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        createLoopPlayer()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        loopPlayer.stop()
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
        self.title = (currentButton["titleKey"] as! String)
        let resourceName = currentButton["descriptionKey"] as! String
        
        print(resourceName)
        
        bruhButton.setImage(UIImage(named: resourceName), forState: .Normal)
        
        if let path = NSBundle.mainBundle().pathForResource(resourceName, ofType: ".m4a") {
            let url = NSURL(fileURLWithPath: path)
            print("File URL: \(url)")
            do {
                loopPlayer = try AVAudioPlayer(contentsOfURL: url)
                loopPlayer.prepareToPlay()
                loopPlayer.numberOfLoops = 0
            } catch {
                let alert = UIAlertController(title: "Oops", message: "Looks like the clip could not load :(", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Okay :(", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Oops", message: "Looks like something didn't load quite right :(", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay :(", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func showSettings() {
        let settingsVC = SettingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func showButtons() {
        let buttonSelection = ButtonSelectionViewController()
        buttonSelection.titleString = "Choose a button"
        buttonSelection.source = "fromHome"
        buttonSelection.delegate = self
        let nav = UINavigationController(rootViewController: buttonSelection)
        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
    }

}

// MARK: - Button selection delegate methods

extension ViewController: ButtonSelectionDelegate {
    func didSelectButton(sender: [String : AnyObject]) {
        loopPlayer.stop()
        currentButton = sender
        NSUserDefaults.standardUserDefaults().setObject(sender, forKey: "LastButtonUsed")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

