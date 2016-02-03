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
        // Do any additional setup after loading the view, typically from a nib.
        
        if NSUserDefaults.standardUserDefaults().boolForKey("UseDefault") {
            currentButton = NSUserDefaults.standardUserDefaults().dictionaryForKey("DefaultButton")!
            print("Current button: \(currentButton)")
        } else {
            currentButton = NSUserDefaults.standardUserDefaults().dictionaryForKey("LastUsedButton")!
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
        createLoopPlayer()
    }
    
    override func viewWillAppear(animated: Bool) {
        print("View is appearing...")
        //createLoopPlayer()
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
        
        //let buttonResource = NSUserDefaults.standardUserDefaults().dictionaryForKey("DefaultButton")!
        //print("Default button: \(buttonResource)")
        
        self.title = (currentButton["titleKey"] as! String)
        let resourceName = currentButton["descriptionKey"] as! String
        
        print(resourceName)
        
        let path = NSBundle.mainBundle().pathForResource(resourceName, ofType: ".m4a")
        print("File path: \(path)")
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
        print("Selected button from selection: \(sender)")
        currentButton = sender
        print("Current after selection: \(currentButton)")
        createLoopPlayer()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

