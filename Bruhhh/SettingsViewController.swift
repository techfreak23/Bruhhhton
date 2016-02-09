//
//  SettingsViewController.swift
//  Bruhhh
//
//  Created by Art Sevilla on 1/30/16.
//  Copyright © 2016 Mac Demo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    let menuOptions = ["Default button", "Button shortcuts", "Use Default Button"]
    var useDefault: UISwitch?
    var shouldUseDefault = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shouldUseDefault = NSUserDefaults.standardUserDefaults().boolForKey("UseDefault")
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.backgroundColor = UIColor.init(red: 56/255, green: 3/255, blue: 98/255, alpha: 1.0)
        self.tableView.separatorStyle = .None
        
        self.title = "Settings"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func switchToggled(sender: UISwitch) {
        shouldUseDefault = sender.on ? true : false
        NSUserDefaults.standardUserDefaults().setBool(shouldUseDefault, forKey: "UseDefault")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text = menuOptions[indexPath.row]
        
        if indexPath.row == 2 {
            useDefault = UISwitch()
            useDefault?.addTarget(self, action: "switchToggled:", forControlEvents: .ValueChanged)
            useDefault?.setOn(shouldUseDefault, animated: false)
            cell.accessoryView = self.useDefault!
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let buttonSelection = ButtonSelectionViewController()
            buttonSelection.titleString = "Choose a default button"
            buttonSelection.delegate = self
            self.navigationController?.pushViewController(buttonSelection, animated: true)
            
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

}

extension SettingsViewController: ButtonSelectionDelegate {
    func didSelectButton(sender: [String : AnyObject]) {
        NSUserDefaults.standardUserDefaults().setObject(sender, forKey: "DefaultButton")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func didCancel() {
        print("Nothing to do here")
    }
}
