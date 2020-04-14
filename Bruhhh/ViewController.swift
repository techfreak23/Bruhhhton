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
        
        if UserDefaults.standard.bool(forKey: "UseDefault") {
            currentButton = UserDefaults.standard.dictionary(forKey: "DefaultButton")! as [String : AnyObject]
            UserDefaults.standard.set(currentButton, forKey: "LastButtonUsed")
            print("Current button: \(currentButton)")
        } else {
            currentButton = UserDefaults.standard.dictionary(forKey: "LastButtonUsed")! as [String : AnyObject]
            print("Last used button: \(currentButton)")
        }
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let titleDict:[NSAttributedString.Key : Any]? = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white]
        //let foregroundColor: NSAttributedStringKey
        //print("Dict: \(titleDict)")
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        
        let buttonImage = UIImage(named: "System-settings-icon")
        let menuButtonImage = UIImage(named: "menu-icon")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(ViewController.showSettings))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage, style: .plain, target: self, action: #selector(ViewController.showButtons))
        
        bruhButton.layer.cornerRadius = 100.0
        bruhButton.layer.borderColor = UIColor.gray.cgColor
        bruhButton.layer.borderWidth = 3.0
        bruhButton.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createLoopPlayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loopPlayer.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playBruh(_ sender: AnyObject) {
        loopPlayer.currentTime = 0
        loopPlayer.play()
        
    }
    
    func createLoopPlayer() {
        self.title = (currentButton["titleKey"] as! String)
        let resourceName = currentButton["descriptionKey"] as! String
        
        print(resourceName)
        
        bruhButton.setImage(UIImage(named: resourceName), for: UIControl.State())
        
        if let path = Bundle.main.path(forResource: resourceName, ofType: ".m4a") {
            let url = URL(fileURLWithPath: path)
            print("File URL: \(url)")
            do {
                loopPlayer = try AVAudioPlayer(contentsOf: url)
                loopPlayer.prepareToPlay()
                loopPlayer.numberOfLoops = 0
            } catch {
                let alert = UIAlertController(title: "Oops", message: "Looks like the clip could not load :(", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay :(", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Oops", message: "Looks like something didn't load quite right :(", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay :(", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func showSettings() {
        let settingsVC = SettingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc func showButtons() {
        let buttonSelection = ButtonSelectionViewController()
        buttonSelection.titleString = "Choose a button"
        buttonSelection.source = "fromHome"
        buttonSelection.delegate = self
        let nav = UINavigationController(rootViewController: buttonSelection)
        self.navigationController?.present(nav, animated: true, completion: nil)
        
    }

}

// MARK: - Button selection delegate methods

extension ViewController: ButtonSelectionDelegate {
    func didSelectButton(_ sender: [String : AnyObject]) {
        currentButton = sender
        UserDefaults.standard.set(sender, forKey: "LastButtonUsed")
        self.dismiss(animated: true, completion: nil)
    }
    
    func didSelectShortcuts() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

