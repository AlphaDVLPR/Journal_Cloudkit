//
//  EntryListTableViewController.swift
//  Journal_CloudKit
//
//  Created by AlphaDVLPR on 10/14/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "EntryList"
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = EntryController.shared.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.formatDate()
        
        return cell
    }
    
    //MARK: - Helper Functions
    private func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func loadData() {
        EntryController.shared.fetchEntry { (success) in
            if success {
                self.updateViews()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "entryDetailVC" {
            guard let index = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? DetailEntryViewController else {return}
            
            let entryData = EntryController.shared.entries[index.row]
            destinationVC.incomingEntryData = entryData
        }
    }
}
