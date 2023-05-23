//
//  TryViewController.swift
//  Sports
//
//  Created by Mac on 20/05/2023.
//

import UIKit

class TryViewController: UIViewController {

    @IBOutlet weak var tryLabel: UILabel!
    
    var leagueId:String?
    var tt :String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let  apiFetch = FetchAllLeagues()
        
//        apiFetch.getUpCommingEvent(leagueId: leagueId!, from: "2023-05-20", to:"2024-05-20" ){[weak self] (root: FootballRoot?) in
//            self?.tt = root?.result?[0].league_name ?? ""
//            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n",self?.tt ?? "AyHaga")
//        }
        
        
        print("*************************",tt)
        tryLabel.text = tt
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
