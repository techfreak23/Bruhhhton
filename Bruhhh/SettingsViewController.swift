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
        
        shouldUseDefault = UserDefaults.standard.bool(forKey: "UseDefault")
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.backgroundColor = UIColor.init(red: 56/255, green: 3/255, blue: 98/255, alpha: 1.0)
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
        self.title = "Settings"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func switchToggled(_ sender: UISwitch) {
        shouldUseDefault = sender.isOn ? true : false        
        UserDefaults.standard.set(shouldUseDefault, forKey: "UseDefault")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = menuOptions[indexPath.row]
        
        if indexPath.row == 2 {
            useDefault = UISwitch()
            useDefault?.addTarget(self, action: #selector(SettingsViewController.switchToggled(_:)), for: .valueChanged)
            useDefault?.setOn(shouldUseDefault, animated: false)
            cell.accessoryView = self.useDefault!
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let buttonSelection = ButtonSelectionViewController()
            buttonSelection.titleString = "Choose a default button"
            buttonSelection.source = "fromSettings"
            buttonSelection.delegate = self
            self.navigationController?.pushViewController(buttonSelection, animated: true)
            
        } else if indexPath.row == 1 {
            let buttonSelection = ButtonSelectionViewController()
            buttonSelection.titleString = "Choose shortcuts"
            buttonSelection.source = "shortcutSelection"
            buttonSelection.delegate = self
            self.navigationController?.pushViewController(buttonSelection, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }

}

extension SettingsViewController: ButtonSelectionDelegate {
    func didSelectButton(_ sender: [String : AnyObject]) {
        UserDefaults.standard.set(sender, forKey: "DefaultButton")
        self.navigationController?.popViewController(animated: true)
    }
    
    func didSelectShortcuts() {
        print("We have selected shortcuts")
        self.navigationController?.popViewController(animated: true)
    }
    
    func didCancel() {
        print("Nothing to do here")
    }
}
