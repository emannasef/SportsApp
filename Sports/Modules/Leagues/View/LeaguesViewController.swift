//
//  ViewController.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import UIKit
import Kingfisher
class LeaguesViewController: UIViewController {
    
    var sportTitle  :String = ""
    var arr: [League] = []
    var leaguesViewModel:LeaguesViewModel?

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Leagues"
        tableView.dataSource = self
        tableView.delegate = self
        
        Utlies.registerCell(tableView: tableView)
        
        if sportTitle == "Football" {
            leaguesViewModel = LeaguesViewModel(apiFetchHandler: APIFetch(),mySport: Constants.fromFootball)
        }else if sportTitle == "Basketball" {
            leaguesViewModel = LeaguesViewModel(apiFetchHandler: APIFetch(),mySport: Constants.fromBasketball)
        }else if sportTitle == "Tennis" {
            leaguesViewModel = LeaguesViewModel(apiFetchHandler: APIFetch(),mySport: Constants.fromTennis)
        }else if sportTitle == "Cricket" {
            leaguesViewModel = LeaguesViewModel(apiFetchHandler: APIFetch(),mySport: Constants.fromCricket)
        }
        
        leaguesViewModel?.getData()

        leaguesViewModel?.bindResultToView = { [weak self] in
            self?.arr = self?.leaguesViewModel?.res ?? []
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        
    }
    
    
}
extension LeaguesViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        let league = arr[indexPath.row]

        cell.cellName.text = league.league_name
        
        let imgUrl = URL(string: league.league_logo ?? " ")
        
        cell.cellImg.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: "leaguePlaceHolder.png"))
        
        cell.cellImg.layer.cornerRadius = (cell.cellImg.frame.height)/2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let lDvc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetails") as! LeagueDetailsViewController
        
//        let lDvc = self.storyboard?.instantiateViewController(withIdentifier: "Details") as! DetailsViewController
        
        lDvc.insertLeague =  arr[indexPath.row]
        lDvc.leagueId = String(arr[indexPath.row].league_key ?? 0)
        lDvc.sport = sportTitle
        lDvc.fromScreen = "Home"
        lDvc.modalPresentationStyle = .fullScreen
        self.present(lDvc, animated: true, completion: nil)
    }

}

