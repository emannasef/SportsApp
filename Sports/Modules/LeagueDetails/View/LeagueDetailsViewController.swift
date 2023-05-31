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
    
    var detailsViewModel:LeagueDetailsViewModel?
    var favViewModel:FavViewModel?
    var fromScreen :String!
    let indicator=UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utlies.dateForCurrentEvents()
        Utlies.dateForLatestResEvents()
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
        indicator.startAnimating()
        
        favViewModel = FavViewModel(myCoreData: MyCoreData.sharedInstance)
        
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
        }
        
        
        detailsViewModel?.getUpcomingEvents()
        detailsViewModel?.bindResultToView = { [weak self] in
            self?.upCommingArr = self?.detailsViewModel?.res ?? []
            self?.getTeam ()
            DispatchQueue.main.async {
                self?.indicator.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
        
        
        detailsViewModel?.getLatestEvents()
        detailsViewModel?.bindLatestToView = { [weak self] in
            self?.latestResultArr = self?.detailsViewModel?.latestRes ?? []
            self?.getTeam ()
            DispatchQueue.main.async {
                self?.indicator.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
        
        
        if fromScreen == "Fav" {
            addToFavImg.isHidden = true
        }
        else{

            if  favViewModel?.isLeagueExist(league: insertLeague) == true {
                addToFavImg.image = UIImage(named: "filled.png")
            }else{
                addToFavImg.image = UIImage(named: "outlined.png")
            }

        }
        
        
        let tab = UITapGestureRecognizer(target: self, action: #selector(addToFav(_:)))
        addToFavImg.addGestureRecognizer(tab)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        
        let layout = UICollectionViewCompositionalLayout{index, environment in
            
            switch index {
            case 0 :
                return self.titleSection()
            case 1 :
                return self.upCommingSection()
            case 2 :
                return self.titleSection()
            case 3 :
                return self.latestResulsection()
            case 4 :
                return self.titleSection()
            case 5 :
                return self.teamsSection()
            default:
                return self.upCommingSection()
            }
            
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    @objc func addToFav(_ sender:UITapGestureRecognizer) {

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
    
    @IBAction func goToLastScreen(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    
}

extension LeagueDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0 :
            return 1
        case 1 :
            return upCommingArr.count
        case 2 :
            return 1
        case 3 :
            return latestResultArr.count
        case 4 :
            return 1
        case 5 :
            return teamArr.count
            
        default:
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.headerCell.text = "Upcomming Events"
            
            return cell
            
        case 1:
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
            
        case 2 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.headerCell.text = "Latest Events"
            return cell
            
        case 3 :
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestResultCell", for: indexPath) as! LatestResultCell
            let latestRes = latestResultArr[indexPath.row]
            
            cell.bgImage.layer.borderWidth = 1.5
            cell.bgImage.layer.borderColor = UIColor.blue.cgColor
            cell.bgImage.layer.cornerRadius = 8
            cell.homeName.text = latestRes.event_home_team
            cell.awayName.text = latestRes.event_away_team
            cell.finalResult.text = latestRes.event_final_result ?? "2-1"
            
            let imgHomeTeamUrl = URL(string: latestRes.home_team_logo ?? "")
            
            cell.homeTeamImg.kf.setImage(
                with: imgHomeTeamUrl,
                placeholder: UIImage(named: "placeHolder.png"))
            
            let imgAwayTeamUrl = URL(string: latestRes.away_team_logo ?? "")
            
            cell.awayTeamImg.kf.setImage(
                with: imgAwayTeamUrl,
                placeholder: UIImage(named: "placeHolder.png"))
            
            
            return cell
        case 4 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.headerCell.text = "Teams"
            return cell
            
        case 5 :
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
        if indexPath.section == 5 {
            let tvc = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetails") as! TeamViewController
            
            tvc.teamId = String(teamArr[indexPath.row].team_key ?? 0)
            tvc.sport = myTeamSport
            tvc.modalPresentationStyle = .fullScreen
            self.present(tvc, animated: true, completion: nil)
        }
    }
    
 
    
    func upCommingSection()-> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension:  .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        animation(section: section)
        return section
    }
    
    func titleSection() -> NSCollectionLayoutSection{
            let itemSize = NSCollectionLayoutSize (widthDimension:
                    .fractionalWidth(1), heightDimension: .fractionalHeight (1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize (widthDimension:
                    .fractionalWidth(1), heightDimension: .absolute (50))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize:
            groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0)
            
            return section
        }
    
    
    
    func latestResulsection()->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                               , heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                      , bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 7
                                                        , bottom: 0, trailing: 16)
        
        return section
    }
    
    func teamsSection()->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension:  .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
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
