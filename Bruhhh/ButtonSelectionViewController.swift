//
//  ButtonSelectionViewController.swift
//  Bruhhh
//
//  Created by Art Sevilla on 1/30/16.
//  Copyright © 2016 Mac Demo. All rights reserved.
//

import UIKit

protocol ButtonSelectionDelegate: class {
    func didSelectButton(_ sender: [String: AnyObject])
    func didCancel()
    func didSelectShortcuts()
}

class ButtonSelectionViewController: UITableViewController {
    
    let descriptionKey = "descriptionKey"
    let titleKey = "titleKey"
    let favoriteKey = "favoriteKey"
    var titleString = ""
    var source = ""
    var buttonOptions = NSMutableArray()
    var buttonShortcuts = NSMutableArray()
    var lastUsed: AnyObject?
    var defaultButton: AnyObject?
    var selectedButton: AnyObject?
    var selectedIndex = -1
    
    weak var delegate:ButtonSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastUsed = UserDefaults.standard.dictionary(forKey: "LastButtonUsed") as AnyObject
        defaultButton = UserDefaults.standard.dictionary(forKey: "DefaultButton") as AnyObject
        buttonShortcuts.addObjects(from: UserDefaults.standard.array(forKey: "ShortcutButtons")!)
        //print("Button Shortcut from viewDidLoad: \(buttonShortcuts)")
        createButtonOptions()
        
        self.title = titleString
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 56/255, green: 3/255, blue: 98/255, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 56/255, green: 3/255, blue: 98/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let titleDict:[NSAttributedString.Key: Any]? = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.backgroundColor = UIColor.init(red: 56/255, green: 3/255, blue: 98/255, alpha: 1.0)
        self.tableView.separatorStyle = .none
        
        if source == "fromHome" {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ButtonSelectionViewController.cancelSelection))
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ButtonSelectionViewController.saveDefaultButton))
            self.tableView.setEditing(true, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if source == "shortcutSelection" {
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if source == "shortcutSelection" {
            if section == 0 {
                return buttonShortcuts.count
            } else {
                return buttonOptions.count
            }
        } else {
            return buttonOptions.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        if indexPath.section == 0 {
            return .delete
        } else {
            return .insert
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel.init()
        
        if source == "shortcutSelection" {
            headerLabel.textColor = UIColor.init(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
            headerLabel.backgroundColor = UIColor.init(red: 195/255, green: 195/255, blue: 229/255, alpha: 1.0) //UIColor.init(red: 56/255, green: 3/255, blue: 98/255, alpha: 1.0)
            
            if section == 0 {
                headerLabel.text = "  3D Touch Shortcuts"
            } else {
                headerLabel.text = "  Other buttons"
            }
            return headerLabel
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell
        
        let defaultTitle = defaultButton!.object(forKey: "titleKey") as! String
        let lastUsedTitle = lastUsed!.object(forKey: "titleKey") as! String
        var button: AnyObject?
        
        if source == "shortcutSelection" {
            if indexPath.section == 0 {
                button = buttonShortcuts.object(at: indexPath.row) as AnyObject
            } else {
                button = buttonOptions.object(at: indexPath.row) as AnyObject
            }
        } else  {
            button = buttonOptions.object(at: indexPath.row) as AnyObject
        }
        
        
        
        let titleText = (button as AnyObject).object(forKey: "titleKey") as! String
        
        print("Var: \(defaultTitle), \(lastUsedTitle), \(String(describing: button)), \(titleText)")
        
        
        if source == "fromHome" {
            if titleText == lastUsedTitle {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else if source == "fromSettings" {
            if titleText == defaultTitle {
                cell.accessoryType = .checkmark
                selectedIndex = indexPath.row
                selectedButton = button as AnyObject
            } else {
                //cell.accessoryType = .none
            }
        } else if source == "shortcutSelection" {
            //let shortcutInfo =
            //let cellTitle = buttonShortcuts.objectAtIndex(indexPath.row.
            //cell.accessoryType = .none
        }
        
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = titleText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if source == "fromHome" {
            self.delegate?.didSelectButton(buttonOptions.object(at: indexPath.row) as! [String : AnyObject])
            
        } else if source == "fromSettings" {
            if indexPath.row != self.selectedIndex {
                let cell = tableView.cellForRow(at: IndexPath(row: self.selectedIndex, section: 0))
                let newCell = tableView.cellForRow(at: indexPath)
                cell?.accessoryType = .none
                newCell?.accessoryType = .checkmark
                self.selectedIndex = indexPath.row
                self.selectedButton = self.buttonOptions.object(at: indexPath.row) as AnyObject
                
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return true
        } else {
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("Move row \(sourceIndexPath) to \(destinationIndexPath)")
        
        if sourceIndexPath.section == 0 {
            let item1 = self.buttonShortcuts.object(at: sourceIndexPath.row)
            
            if destinationIndexPath.section == 0 {
                self.buttonShortcuts.removeObject(at: sourceIndexPath.row)
                self.buttonShortcuts.insert(item1, at: destinationIndexPath.row)
                print("Reordered button shortcuts: \(buttonShortcuts)")
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section == 0 && proposedDestinationIndexPath.section == 1 {
            return sourceIndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("Edit button for style \(editingStyle) pressed at index \(indexPath)")
    }
    
    @objc func cancelSelection() {
        self.delegate?.didCancel()
    }
    
    @objc func saveDefaultButton() {
        if (source == "shortcutSelection") {
            self.delegate?.didSelectShortcuts()
        } else {
            self.delegate?.didSelectButton(selectedButton as! [String: AnyObject])
        }
    }
    
    func saveToUserDefaults() {
        UserDefaults.standard.setValue(self.buttonShortcuts, forKey: "ShortcutButtons")
        print("Shortcut Buttons from User Defaults: \(String(describing: UserDefaults.standard.value(forKey: "ShortcutButtons")))")
    }
    
    func createButtonOptions() {
        //let instaRap: [String: Any?] = [titleKey: "Airhorn", descriptionKey: "instarapairhorn", favoriteKey: 0]
        let archerFail: [String: Any?] = [titleKey: "Archer Fail", descriptionKey: "archer-fail", favoriteKey: 0]
        let cutHim: [String: Any?] = [titleKey: "Girl, I Cut Him", descriptionKey: "bon-qui-girl-i-cut-him", favoriteKey: 0]
        let rude: [String: Any?] = [titleKey: "Rude", descriptionKey: "bon-qui-rude", favoriteKey: 0]
        let security: [String: Any?] = [titleKey: "Security", descriptionKey: "bon-qui-security", favoriteKey: 0]
        let bruh: [String: Any?] = [titleKey: "Bruh", descriptionKey: "bruh-sound-effect", favoriteKey: 0]
        let byeFelicia: [String: Any?] = [titleKey: "Bye Felicia", descriptionKey: "bye-felicia", favoriteKey: 0]
        //let cashMeOutside: [String: Any?] = [titleKey: "Cash Me Outside", descriptionKey: "cash-me-outside", favoriteKey: 0]
        let hummina: [String: Any?] = [titleKey: "Hummina", descriptionKey: "dave-chappelle-hummina", favoriteKey: 0]
        let deezNuts: [String: Any?] = [titleKey: "Deez Nuts", descriptionKey: "deez-nuts", favoriteKey: 0]
        let gotHim: [String: Any?] = [titleKey: "Got Em", descriptionKey: "got-him", favoriteKey: 0]
        let gotchaBitch: [String: Any?] = [titleKey: "Gotcha Bitch", descriptionKey: "gotcha-bitch", favoriteKey: 0]
        let hahGay: [String: Any?] = [titleKey: "Ha Gay", descriptionKey: "hah-gay", favoriteKey: 0]
        //let inception: [String: Any?] = [titleKey: "Inception", descriptionKey: "inception", favoriteKey: 0]
        //let lindaListen: [String: Any?] = [titleKey: "Linda Listen!", descriptionKey: "linda-listen", favoriteKey: 0]
        //let okayThenWhat: [String: Any?] = [titleKey: "Okay Then What?", descriptionKey: "okay-then-what", favoriteKey: 0]
        //let okayKanye: [String: Any?] = [titleKey: "Okay (Mercy)", descriptionKey: "okay-kanye-song", favoriteKey: 0]
        //let okayVine: [String: Any?] = [titleKey: "Okay (Vine)", descriptionKey: "okay-vine", favoriteKey: 0]
        //let okayShiba: [String: Any?] = [titleKey: "Okay (Shiba San)", descriptionKey: "okay-shiba-san", favoriteKey: 0]
        //let johnCena: [String: Any?] = [titleKey: "John Cena", descriptionKey: "john-cena"]
        //let jesusChrist: [String: Any?] = [titleKey: "Jesus Christ", descriptionKey: "jesus-christ-kid", favoriteKey: 0]
        let shazam: [String: Any?] = [titleKey: "Shazam", descriptionKey: "shazam", favoriteKey: 0]
        let thatsEasy: [String: Any?] = [titleKey: "That Was Easy", descriptionKey: "that-was-easy", favoriteKey: 0]
        let sheSaid: [String: Any?] = [titleKey: "That's What She Said", descriptionKey: "thats-what-she-said"]
        //let theShooting: [String: Any?] = [titleKey: "The Shooting", descriptionKey: "the-shooting"]
        let wrapItUp: [String: Any?] = [titleKey: "Wrap It Up", descriptionKey: "wrap-it-up-music"]
        //let rickSecurity: [String: Any?] = [titleKey: "Security (Rick James)", descriptionKey: "rick-james-security"]
        //let rickCelebration: [String: Any?] = [titleKey: "It's a Celebration", descriptionKey: "rick-james-celebration"]
        //let rickBitch: [String: Any?] = [titleKey: "Rick James, Bitch", descriptionKey: "rick-james-look-bitch"]
        //let rickUnity: [String: Any?] = [titleKey: "Unity", descriptionKey: "rick-james-unity"]
        //let rickCold: [String: Any?] = [titleKey: "Cold Blooded", descriptionKey: "rick-james-cold-blooded"]
        //let crackKidYeah: [String: Any?] = [titleKey: "Crack Kid Yeah", descriptionKey: "crack-kid-yeah"]
        //let yaHuey: [String: Any?] = [titleKey: "Ya Huey", descriptionKey: "ya-huey"]
        //let pinchePendejo: [String: Any?] = [titleKey: "Pinche Pendejo", descriptionKey: "pinche-pendejo"]
        //let hueyScream: [String: Any?] = [titleKey: "Huey Scream", descriptionKey: "huey-scream"]
        //let whoIsIt: [String: Any?] = [titleKey: "Who Is It", descriptionKey: "who-is-it"]
        //let wilhelmScream: [String: Any?]  = [titleKey: "Wilhelm Scream", descriptionKey: "wilhelm-scream"]
        
        //buttonOptions.addObjects(from: [archerFail, cutHim, rude, security, bruh, byeFelicia, cashMeOutside, hummina, deezNuts, gotHim, gotchaBitch, hahGay, inception, lindaListen, okayThenWhat, okayKanye, okayVine, okayShiba, rickSecurity, rickCelebration, rickBitch, rickUnity, rickCold, johnCena, jesusChrist, instaRap, shazam, thatsEasy, sheSaid, theShooting, wrapItUp, crackKidYeah, yaHuey, pinchePendejo, hueyScream, whoIsIt, wilhelmScream])
        buttonOptions.addObjects(from: [archerFail, cutHim, rude, security, bruh, byeFelicia, hummina, deezNuts, gotHim, gotchaBitch, hahGay, shazam, thatsEasy, sheSaid, wrapItUp])
        
        for item in buttonOptions as! [NSDictionary] {
            for itemB in buttonShortcuts as! [NSDictionary] {
                if item.object(forKey: titleKey) as! String == itemB.object(forKey: titleKey) as! String {
                    buttonOptions.remove(item)
                }
            }
        }
        print("Button Shortcuts: \(buttonShortcuts)\nButton Options: \(buttonOptions)")
        self.tableView.reloadData()
    }
    
}
