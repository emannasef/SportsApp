//
//  TeamViewController.swift
//  Sports
//
//  Created by Mac on 22/05/2023.
//

import UIKit
import Kingfisher

class TeamViewController: UIViewController {
    @IBOutlet weak var colectionView: UICollectionView!
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    
    var viewModel:TeamDetailsViewModel?
    
    var teamId:String!
    var sport:String!
    
    var playerArr : [Player] = []
    var res : [ResultTeams]!
    
    var img:String!
    var name:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        colectionView.delegate = self
        colectionView.dataSource = self
        viewModel = TeamDetailsViewModel(apiFetchHandler: APIFetch(), mySport: sport, teamId: teamId)
        
        viewModel?.getData()

        viewModel?.bindResultToView = { [weak self] in
            self?.res = self?.viewModel?.res
            DispatchQueue.main.async {
                
                for i in self?.res ?? [] {
                    
                    self?.playerArr = i.players ?? []
                    self?.colectionView.reloadData()
                
                    self?.teamName.text = i.team_name
                    self?.coachName.text = i.coaches?[0].coach_name
                    let imgUrl = URL(string: i.team_logo ?? "")
                    self?.teamImg.kf.setImage(with: imgUrl,placeholder: UIImage(named: "placeHolder.png"))
                    
                }
                
            }
        }
        
        
    }
    
    @IBAction func backTolastScreen(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    

}




extension TeamViewController :  UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerArr.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PlayerCollectionViewCell
        
       let player = playerArr[indexPath.row]

        let imgUrl = URL(string: player.player_image ?? "")

        cell.playerImage.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: "personPlaceHolder.png"))
        
        cell.playerImage.layer.masksToBounds = true
        cell.playerImage.layer.cornerRadius = cell.playerImage.frame.height / 2
        cell.playerImage.clipsToBounds = true

        cell.playerName.text = player.player_name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.main.bounds.size.width/2-20
                      , height:  80 )
    }
    
    
    
}
