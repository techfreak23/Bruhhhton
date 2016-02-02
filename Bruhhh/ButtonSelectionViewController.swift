//
//  ButtonSelectionViewController.swift
//  Bruhhh
//
//  Created by Art Sevilla on 1/30/16.
//  Copyright © 2016 Mac Demo. All rights reserved.
//

import UIKit

class ButtonSelectionViewController: UITableViewController {
    
    //let menuOptions = ["Default button", "Button shortcuts", "When relaunching, use..."]
    
    var buttonOptions = NSMutableArray()
    let descriptionKey = "descriptionKey"
    let titleKey = "titleKey"
    var titleString = ""
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButtonOptions()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let titleDict = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelSelection")
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        self.tableView.backgroundColor = UIColor.init(red: 56/255, green: 3/255, blue: 98/255, alpha: 1.0)
        
        self.title = titleString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        cell.accessoryType = .Checkmark
        
        return cell
    }
    
    func cancelSelection() {
        print("Cancelling selection")
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
