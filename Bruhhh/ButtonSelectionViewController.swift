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
    
    var buttonOptions = NSMutableArray()
    var buttonShortcuts = NSMutableArray()
    let descriptionKey = "descriptionKey"
    let titleKey = "titleKey"
    var titleString = ""
    var source = ""
    var lastUsed: AnyObject?
    var defaultButton: AnyObject?
    var selectedButton: AnyObject?
    var selectedIndex = -1
    
    weak var delegate:ButtonSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButtonOptions()
        
        self.title = titleString
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 56/255, green: 3/255, blue: 98/255, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 56/255, green: 3/255, blue: 98/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let titleDict = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        
        if source == "fromHome" {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ButtonSelectionViewController.cancelSelection))
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ButtonSelectionViewController.saveDefaultButton))
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.backgroundColor = UIColor.init(red: 56/255, green: 3/255, blue: 98/255, alpha: 1.0)
        self.tableView.separatorStyle = .none
        
        lastUsed = UserDefaults.standard.dictionary(forKey: "LastButtonUsed") as AnyObject
        defaultButton = UserDefaults.standard.dictionary(forKey: "DefaultButton") as AnyObject
        buttonShortcuts.addObjects(from: UserDefaults.standard.array(forKey: "ShortcutButtons")!)
        print("Button shortcuts: \(buttonShortcuts)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return buttonOptions.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell
        
        let defaultTitle = defaultButton!.object(forKey: "titleKey") as! String
        let lastUsedTitle = lastUsed!.object(forKey: "titleKey") as! String
        let button = buttonOptions.object(at: indexPath.row)
        let titleText = (button as AnyObject).object(forKey: "titleKey") as! String
        
        print("Var: \(defaultTitle), \(lastUsedTitle), \(button), \(titleText)")
        
        
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
                cell.accessoryType = .none
            }
        } else if source == "shortcutSelection" {
            //let shortcutInfo =
            //let cellTitle = buttonShortcuts.objectAtIndex(indexPath.row.
            cell.accessoryType = .none
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
        } else {
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
    
    func createButtonOptions() {
        let instaRap = [titleKey: "Airhorn", descriptionKey: "instarapairhorn"]
        let archerFail = [titleKey: "Archer Fail", descriptionKey: "archer-fail"]
        let cutHim = [titleKey: "Girl, I Cut Him", descriptionKey: "bon-qui-girl-i-cut-him"]
        let rude = [titleKey: "Rude", descriptionKey: "bon-qui-rude"]
        let security = [titleKey: "Security", descriptionKey: "bon-qui-security"]
        let bruh = [titleKey: "Bruh", descriptionKey: "bruh-sound-effect"]
        let byeFelicia = [titleKey: "Bye Felicia", descriptionKey: "bye-felicia"]
        let cashMeOutside = [titleKey: "Cash Me Outside", descriptionKey: "cash-me-outside"]
        let hummina = [titleKey: "Hummina", descriptionKey: "dave-chappelle-hummina"]
        let deezNuts = [titleKey: "Deez Nuts", descriptionKey: "deez-nuts"]
        let gotHim = [titleKey: "Got Em", descriptionKey: "got-him"]
        let gotchaBitch = [titleKey: "Gotcha Bitch", descriptionKey: "gotcha-bitch"]
        let hahGay = [titleKey: "Ha Gay", descriptionKey: "hah-gay"]
        let inception = [titleKey: "Inception", descriptionKey: "inception"]
        let lindaListen = [titleKey: "Linda Listen!", descriptionKey: "linda-listen"]
        let okayThenWhat = [titleKey: "Okay Then What?", descriptionKey: "okay-then-what"]
        let okayKanye = [titleKey: "Okay (Mercy)", descriptionKey: "okay-kanye-song"]
        let okayVine = [titleKey: "Okay (Vine)", descriptionKey: "okay-vine"]
        let okayShiba = [titleKey: "Okay (Shiba San)", descriptionKey: "okay-shiba-san"]
        let johnCena = [titleKey: "John Cena", descriptionKey: "john-cena"]
        let jesusChrist = [titleKey: "Jesus Christ", descriptionKey: "jesus-christ-kid"]
        let shazam = [titleKey: "Shazam", descriptionKey: "shazam"]
        let thatsEasy = [titleKey: "That Was Easy", descriptionKey: "that-was-easy"]
        let sheSaid = [titleKey: "That's What She Said", descriptionKey: "thats-what-she-said"]
        let theShooting = [titleKey: "The Shooting", descriptionKey: "the-shooting"]
        let wrapItUp = [titleKey: "Wrap It Up", descriptionKey: "wrap-it-up-music"]
        let rickSecurity = [titleKey: "Security (Rick James)", descriptionKey: "rick-james-security"]
        let rickCelebration = [titleKey: "It's a Celebration", descriptionKey: "rick-james-celebration"]
        let rickBitch = [titleKey: "Rick James, Bitch", descriptionKey: "rick-james-look-bitch"]
        let rickUnity = [titleKey: "Unity", descriptionKey: "rick-james-unity"]
        let rickCold = [titleKey: "Cold Blooded", descriptionKey: "rick-james-cold-blooded"]
        let crackKidYeah = [titleKey: "Crack Kid Yeah", descriptionKey: "crack-kid-yeah"]
        let yaHuey = [titleKey: "Ya Huey", descriptionKey: "ya-huey"]
        let pinchePendejo = [titleKey: "Pinche Pendejo", descriptionKey: "pinche-pendejo"]
        let hueyScream = [titleKey: "Huey Scream", descriptionKey: "huey-scream"]
        let whoIsIt = [titleKey: "Who Is It", descriptionKey: "who-is-it"]
        let wilhelmScream = [titleKey: "Wilhelm Scream", descriptionKey: "wilhelm-scream"]
        
        buttonOptions.addObjects(from: [archerFail, cutHim, rude, security, bruh, byeFelicia, cashMeOutside, hummina, deezNuts, gotHim, gotchaBitch, hahGay, inception, lindaListen, okayThenWhat, okayKanye, okayVine, okayShiba, rickSecurity, rickCelebration, rickBitch, rickUnity, rickCold, johnCena, jesusChrist, instaRap, shazam, thatsEasy, sheSaid, theShooting, wrapItUp, crackKidYeah, yaHuey, pinchePendejo, hueyScream, whoIsIt, wilhelmScream])
    }
    
}
