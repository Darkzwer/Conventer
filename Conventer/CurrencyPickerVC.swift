//
//  CurrencyPickerVC.swift
//  Conventer
//
//  Created by Igor on 18/02/2022.
//  Copyright © 2022 DSoft. All rights reserved.
//

import UIKit

class CurrencyPickerVC: UITableViewController {
    
    var сurrencies:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        сurrencies = ["BYN 🇧🇾","RUB 🇷🇺","EUR 🇪🇺","USD 🇺🇸"]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return сurrencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = сurrencies[indexPath.row]
        return cell
    }


}
