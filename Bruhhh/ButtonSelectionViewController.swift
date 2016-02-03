//
//  ButtonSelectionViewController.swift
//  Bruhhh
//
//  Created by Art Sevilla on 1/30/16.
//  Copyright © 2016 Mac Demo. All rights reserved.
//

import UIKit

protocol ButtonSelectionDelegate: class {
    func didSelectButton(sender: [String: AnyObject])
    func didCancel()
}

class ButtonSelectionViewController: UITableViewController {
    
    //let menuOptions = ["Default button", "Button shortcuts", "When relaunching, use..."]
    
    var buttonOptions = NSMutableArray()
    let descriptionKey = "descriptionKey"
    let titleKey = "titleKey"
    var titleString = ""
    var source = ""
    var lastUsed: AnyObject?
    weak var delegate:ButtonSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButtonOptions()
        
        self.title = titleString
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let titleDict = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        
        if source == "fromHome" {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelSelection")
        }
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.backgroundColor = UIColor.init(red: 56/255, green: 3/255, blue: 98/255, alpha: 1.0)
        self.tableView.separatorStyle = .None
        
        lastUsed = NSUserDefaults.standardUserDefaults().dictionaryForKey("LastButtonUsed")
        print("Last button used: \(lastUsed!)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonOptions.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        let titleText = buttonOptions.objectAtIndex(indexPath.row).objectForKey(titleKey) as! String
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text = titleText
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.didSelectButton(buttonOptions.objectAtIndex(indexPath.row) as! [String : AnyObject])
    }
    
    func cancelSelection() {
        self.delegate?.didCancel()
    }
    
    func createButtonOptions() {
        let archerFail = [titleKey: "Archer Fail", descriptionKey: "archer-fail"]
        let cutHim = [titleKey: "Girl, I Cut Him", descriptionKey: "bon-qui-girl-i-cut-him"]
        let rude = [titleKey: "Rude", descriptionKey: "bon-qui-rude"]
        let security = [titleKey: "Security", descriptionKey: "bon-qui-security"]
        let bruh = [titleKey: "Bruh", descriptionKey: "bruh-sound-effect"]
        let byeFelicia = [titleKey: "Bye Felicia", descriptionKey: "bye-felicia"]
        let hummina = [titleKey: "Hummina", descriptionKey: "dave-chappelle-hummina"]
        let deezNuts = [titleKey: "Deez Nuts", descriptionKey: "deez-nuts"]
        let gotHim = [titleKey: "Got Em", descriptionKey: "got-him"]
        let gotchaBitch = [titleKey: "Gotcha Bitch", descriptionKey: "gotcha-bitch"]
        let hahGay = [titleKey: "Ha Gay", descriptionKey: "hah-gay"]
        let shazam = [titleKey: "Shazam", descriptionKey: "shazam"]
        let thatsEasy = [titleKey: "That Was Easy", descriptionKey: "that-was-easy"]
        let sheSaid = [titleKey: "That's What She Said", descriptionKey: "thats-what-she-said"]
        let wrapItUp = [titleKey: "Wrap It Up", descriptionKey: "wrap-it-up-music"]
        
        buttonOptions.addObjectsFromArray([archerFail, cutHim, rude, security, bruh, byeFelicia, hummina, deezNuts, gotHim, gotchaBitch, hahGay, shazam, thatsEasy, sheSaid, wrapItUp])
        
        self.tableView.reloadData()
        
    }
    
}
