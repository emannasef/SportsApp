//
//  Utlies.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import Foundation
import UIKit

class Utlies {
    
    static func registerCell (tableView: UITableView){
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "customCell")
    }
    
}
