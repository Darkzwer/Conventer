//
//  CurrencyPickerVC.swift
//  Conventer
//
//  Created by Igor on 18/02/2022.
//  Copyright © 2022 DSoft. All rights reserved.
//

import UIKit

class CurrencyPickerVC: UITableViewController {
    
    var selectedGame: String? = nil
    var selectedGameIndex: Int? = nil
    
    var games:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Data.сurrencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = Data.сurrencies[indexPath.row]
        
        if indexPath.row == selectedGameIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //other row is selected - need to deselect it
        if let index = selectedGameIndex {
            let cell = tableView.cellForRow(at: NSIndexPath(row: index, section: 0) as IndexPath)
            cell?.accessoryType = .none
        }
        
        selectedGameIndex = indexPath.row
        selectedGame = Data.сurrencies[indexPath.row]
        
        //update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveSelectedGame" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                selectedGameIndex = indexPath?.row
                if let index = selectedGameIndex {
                    selectedGame = games[index]
                }
            }
        }
    }
    
    
}
