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
    
    
    
    static var currentTime:String!
    static  var futureTime:String!
    
    static var myCurrentTime:String!
    static var pastTime:String!
    
    
    
    
    static func dateForCurrentEvents(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        currentTime = dateFormatter.string(from: date)
        
        var dateComponent = DateComponents()
        dateComponent.month = 1
        let LastTimeDate = Calendar.current.date(byAdding: dateComponent, to: date)
        futureTime = dateFormatter.string(from: LastTimeDate!)
        
        
    }
    
    
    static func dateForLatestResEvents(){
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        myCurrentTime = dateFormatter.string(from: date)
        
        var dateComponent = DateComponents()
        dateComponent.month = -2
        let startLatestResultTimeDate = Calendar.current.date(byAdding: dateComponent, to: date)
         pastTime = dateFormatter.string(from: startLatestResultTimeDate!)
        
    }
    
}
