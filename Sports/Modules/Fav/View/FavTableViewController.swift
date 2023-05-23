//
//  FavTableViewController.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import UIKit
import Reachability

class FavTableViewController: UITableViewController {

    var favArr:[League] = []
  //  var coreData:MyCoreData = MyCoreData.sharedInstance
    
    var favViewModel:FavViewModel?
    
    var reachability:Reachability?
    
    var flag :Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        Utlies.registerCell(tableView:tableView)
        favViewModel = FavViewModel(myCoreData: MyCoreData.sharedInstance)
        
        do{
            reachability = try Reachability()
            try reachability?.startNotifier()
            
        }catch{
            print("cant creat object of rechability")
            print("Unable to start notifier")
        }
        
        reachability?.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("ReachableEman via WiFi")
                self.flag = true
            } else {
                print("ReachableEman via Cellular")
            }
        }
        reachability?.whenUnreachable = { _ in
            print("NotEman reachable")
            self.flag = false
        }
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        favArr = coreData.getStoredLeagues()
 
        favArr = favViewModel?.getSoredFavs() ?? []
        tableView.reloadData()
     
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        let imgHomeTeamUrl = URL(string: favArr[indexPath.row].league_logo ?? "")
        
        cell.cellImg.kf.setImage(
            with: imgHomeTeamUrl,
            placeholder: UIImage(named: "placeHolder.png"))
        
        cell.cellName.text = favArr[indexPath.row].league_name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if flag == true {
                        
            let lDvc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetails") as! LeagueDetailsViewController
            lDvc.fromScreen = "Fav"
            let lea = favArr[indexPath.row]
            lDvc.leagueId = String(lea.league_key ?? 0)
            lDvc.sport = lea.sport
           // print("Fav Sport",lea.sport)
           // self.present(lDvc, animated: true, completion: nil)
            self.navigationController?.pushViewController(lDvc, animated: true)
        }else{
            showNoConnectionAlert()
        }

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            showAlert(index: indexPath.row)
            
        }
    }
    
    func deleteFavLeague(index : Int){
        let league : League = favArr[index]
       // self.coreData.deleteFavLeague(league: league)
       // favArr = self.coreData.getStoredLeagues()
        
        favViewModel?.deleteFavLeague(league: league)
        favArr = favViewModel?.getSoredFavs() ?? []
        tableView.reloadData()
    }
    
 
    func showAlert(index : Int){
        
        let alert : UIAlertController = UIAlertController(title: "Delete League", message: "Are you sure that, Do yo want to delete league?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            self.deleteFavLeague(index: index)
            
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func showNoConnectionAlert(){
        
        let alert : UIAlertController = UIAlertController(title: "Not Connected", message: "you are have no network connection, please connect and try again ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
       
        self.present(alert, animated: true, completion: nil)
        
    }
    

}
