//
//  FavViewController.swift
//  Sports
//
//  Created by Mac on 30/05/2023.
//

import UIKit
import Reachability

class FavViewController: UIViewController {
    
    @IBOutlet weak var noFavImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var favArr:[League] = []
    var favViewModel:FavViewModel?
    var reachability:Reachability?
    var flagForRech :Bool?
    var flagForImage:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "Favorite"
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
                print("Reachable via WiFi")
                self.flagForRech = true
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability?.whenUnreachable = { _ in
            print("Not reachable")
            self.flagForRech = false
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if favViewModel?.getSoredFavs().count != 0 {
            favArr = favViewModel?.getSoredFavs() ?? []
            tableView.reloadData()
            noFavImg.isHidden = true
            self.navigationItem.title = "Favourite"
        }else{
            noFavImg.isHidden = false
            noFavImg.image = UIImage(named:"noFav")
            self.navigationItem.title = "No Favourite Leagues yet"
        }
        
        //        favArr = favViewModel?.getSoredFavs() ?? []
        //        tableView.reloadData()
    }
    
    
}

extension FavViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        let imgHomeTeamUrl = URL(string: favArr[indexPath.row].league_logo ?? "")
        
        cell.cellImg.kf.setImage(
            with: imgHomeTeamUrl,
            placeholder: UIImage(named: "leaguePlaceHolder.png"))
        
        cell.cellName.text = favArr[indexPath.row].league_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if flagForRech == true {
            
            let lDvc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetails") as! LeagueDetailsViewController
            lDvc.fromScreen = "Fav"
            let lea = favArr[indexPath.row]
            lDvc.leagueId = String(lea.league_key ?? 0)
            lDvc.sport = lea.sport
            // print("Fav Sport",lea.sport)
            lDvc.modalPresentationStyle = .fullScreen
            self.present(lDvc, animated: true, completion: nil)
        }else{
            showNoConnectionAlert()
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert(index: indexPath.row)
        }
    }
    
    func deleteFavLeague(index : Int){
        let league : League = favArr[index]
        favViewModel?.deleteFavLeague(league: league)
        favArr = favViewModel?.getSoredFavs() ?? []
        
        if self.favArr.count == 0{
            self.noFavImg.isHidden = false
            self.noFavImg.image = UIImage(named:"noFav")
            self.navigationItem.title = "No Favourite Leagues yet"
        }else{
            self.noFavImg.isHidden = true
            self.navigationItem.title = "Favourite"
        }
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
