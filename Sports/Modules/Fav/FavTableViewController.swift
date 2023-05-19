//
//  FavTableViewController.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import UIKit

class FavTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Utlies.registerCell(tableView:tableView)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        cell.cellImg.image = UIImage(named: "placeHolder")
        cell.cellTitle.text = "Eman"
        return cell
    }

   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 5 - 20
    }

}
