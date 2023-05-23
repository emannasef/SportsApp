//
//  LeagueDetailsViewController.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import UIKit
import Kingfisher
class LeagueDetailsViewController: UIViewController {
    
    @IBOutlet weak var addToFavImg: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var leagueId : String!
    var sport : String!
    var myTeamSport:String!
    
    var upCommingArr : [LeagueDetails] = []
    var latestResultArr:[LeagueDetails] = []
    
    var teamArr:[Team] = []
    var teamDic:[Int:Team] = [:]
    var insertLeague:League = League()
    
    var detailsViewModel:LeagueDetailsViewModel!
    var coreData:MyCoreData = MyCoreData.sharedInstance
    var favViewModel:FavViewModel?
    var fromScreen :String!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favViewModel = FavViewModel(myCoreData: MyCoreData.sharedInstance)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        Utlies.dateForCurrentEvents()
        Utlies.dateForLatestResEvents()
        
        if fromScreen == "Fav" {
            addToFavImg.isHidden = true
        }
        else{
            
//            if  coreData.isLeagueExist(league: insertLeague) == true {
//                addToFavImg.image = UIImage(named: "filled.png")
//            }else{
//                addToFavImg.image = UIImage(named: "outlined.png")
//            }
            
            
            if  favViewModel?.isLeagueExist(league: insertLeague) == true {
                addToFavImg.image = UIImage(named: "filled.png")
            }else{
                addToFavImg.image = UIImage(named: "outlined.png")
            }
            
        }
        
        
        let tab = UITapGestureRecognizer(target: self, action: #selector(addToFav(_:)))
        addToFavImg.addGestureRecognizer(tab)
        
        
        //        print("#################################CutterntTime\n",Utlies.currentTime)
        //        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$FutureTime\n",Utlies.futureTime)
        //
        //        print("#################################MyCutterntTime\n",Utlies.myCurrentTime)
        //        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$PastTime\n",Utlies.pastTime)
        
        if sport == "Football"
        {
            detailsViewModel = LeagueDetailsViewModel(apiFetchHandler: APIFetch(), myId: leagueId, sport: Constants.fromFootballFixture)
            
            myTeamSport = Constants.fromFootballTeam
            
            insertLeague.sport = "Football"
            
        }else if sport == "Basketball" {
            
            detailsViewModel = LeagueDetailsViewModel(apiFetchHandler: APIFetch(), myId: leagueId, sport: Constants.fromBasketballFixture)
            myTeamSport = Constants.fromBasketballTeam
            insertLeague.sport = "Basketball"
            
        }else if sport == "Tennis" {
            
            detailsViewModel = LeagueDetailsViewModel(apiFetchHandler: APIFetch(), myId: leagueId, sport: Constants.fromTennisFixture)
            myTeamSport = Constants.fromTennisTeam
            insertLeague.sport = "Tennis"
            
        }else if sport == "Cricket" {
            
            detailsViewModel = LeagueDetailsViewModel(apiFetchHandler: APIFetch(), myId: leagueId, sport: Constants.fromCricketFixture)
            myTeamSport = Constants.fromCricketTeam
            insertLeague.sport = "Cricket"
        }else{
            
        }
        
        
        detailsViewModel?.getUpcomingEvents()
        
        detailsViewModel.bindResultToView = { [weak self] in
            self?.upCommingArr = self?.detailsViewModel?.res ?? []
            self?.getTeam ()
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        
        detailsViewModel?.getLatestEvents()
        
        detailsViewModel.bindLatestToView = { [weak self] in
            self?.latestResultArr = self?.detailsViewModel?.latestRes ?? []
            self?.getTeam ()
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        
        
        let layout = UICollectionViewCompositionalLayout{index, environment in
            
            switch index {
            case 0 :
                return self.upCommingSection()
            case 1 :
                return self.latestResulsection()
            case 2 :
                return self.teamsSection()
            default:
                return self.upCommingSection()
            }
            
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        
        
    }
    
    @objc func addToFav(_ sender:UITapGestureRecognizer) {
        
//        if  coreData.isLeagueExist(league: insertLeague) == false {
//
//            coreData.insertFavLeague(leagueInserted: insertLeague)
//            addToFavImg.image = UIImage(named: "filled.png")
//
//        }else{
//            coreData.deleteFavLeague(league: insertLeague)
//            addToFavImg.image = UIImage(named: "outlined.png")
//
//        }
        
        if  favViewModel?.isLeagueExist(league: insertLeague) == false {
            
            favViewModel?.insertFavLeague(league: insertLeague)
            addToFavImg.image = UIImage(named: "filled.png")
            
        }else{
            favViewModel?.deleteFavLeague(league: insertLeague)
            addToFavImg.image = UIImage(named: "outlined.png")
            
        }
        

    }
    
    
    func getTeam (){
        let arr = upCommingArr + latestResultArr
        for element in arr {
            teamDic.updateValue(Team(team_key: element.home_team_key,team_name: element.event_home_team,team_logo: element.home_team_logo), forKey: element.home_team_key!)
            
            teamDic.updateValue(Team(team_key: element.away_team_key,team_name: element.event_away_team,team_logo: element.away_team_logo), forKey: element.away_team_key!)
        }
        
        teamArr = Array(teamDic.values)
    }
    

    
}

extension LeagueDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0 :
            return upCommingArr.count
        case 1 :
            return latestResultArr.count
        case 2 :
            return teamArr.count
            
        default:
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpCommingCell", for: indexPath) as! UpCommingCell
            let league = upCommingArr[indexPath.row]
            
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = UIColor.blue.cgColor
            cell.layer.cornerRadius = 8
            
            let imgHomeTeamUrl = URL(string: league.home_team_logo ?? "")
            
            cell.homeTeamLogo.kf.setImage(
                with: imgHomeTeamUrl,
                placeholder: UIImage(named: "placeHolder.png"))
            
            let imgAwayTeamUrl = URL(string: league.away_team_logo ?? "")
            
            cell.awayTeamLogo.kf.setImage(
                with: imgAwayTeamUrl,
                placeholder: UIImage(named: "placeHolder.png"))
            
            cell.eventDateLB.text = league.event_date
            cell.eventTimeLB.text = league.event_time
            cell.eventHomeName.text = league.event_home_team
            cell.eventAwayName.text = league.event_away_team
            
            return cell
        case 1 :
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestResultCell", for: indexPath) as! LatestResultCell
            let latestRes = latestResultArr[indexPath.row]
            
            // cell.finalResult.text = latestRes?.goalscorers[0].away_scorer
            
            let imgHomeTeamUrl = URL(string: latestRes.home_team_logo ?? "")
            
            cell.homeTeamImg.kf.setImage(
                with: imgHomeTeamUrl,
                placeholder: UIImage(named: "placeHolder.png"))
            
            let imgAwayTeamUrl = URL(string: latestRes.away_team_logo ?? "")
            
            cell.awayTeamImg.kf.setImage(
                with: imgAwayTeamUrl,
                placeholder: UIImage(named: "placeHolder.png"))
            
            return cell
            
            
        case 2 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCell
            
            let imgHomeTeamUrl = URL(string: teamArr[indexPath.row].team_logo ?? "")
            
            cell.teamImg.kf.setImage(
                with: imgHomeTeamUrl,
                placeholder: UIImage(named: "placeHolder.png"))
            
            cell.teamImg.layer.masksToBounds = true
            cell.teamImg.layer.cornerRadius = cell.teamImg.frame.height / 2
            cell.teamImg.clipsToBounds = true
            cell.teamName.text = teamArr[indexPath.row].team_name
            
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpCommingCell", for: indexPath) as! UpCommingCell
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let tvc = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetails") as! TeamViewController
            
            tvc.teamId = String(teamArr[indexPath.row].team_key ?? 0)
            tvc.sport = myTeamSport
            
            self.navigationController?.pushViewController(tvc, animated: true)
        }
    }
    
 
    
    func upCommingSection()-> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.80), heightDimension:  .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0)
        
        animation(section: section)
        return section
    }
    
    
    
    func latestResulsection()->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                               , heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                      , bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                                                        , bottom: 10, trailing: 15)
        
        return section
    }
    
    func teamsSection()->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension:  .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0)
        
        animation(section: section)
        
        return section
    }
    
    func animation(section:NSCollectionLayoutSection){
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
    }
    
    
    
}
