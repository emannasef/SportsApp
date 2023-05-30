//
//  MyCoreData.swift
//  Sports
//
//  Created by Mac on 21/05/2023.
//

import Foundation
import CoreData
import UIKit

class MyCoreData :MyCorDataProtocol{
    
    var manager : NSManagedObjectContext!
    var leaguesArr : [NSManagedObject] = []
    var leagueToBeDeleted : NSManagedObject?
    
    static let sharedInstance = MyCoreData()
    
    private init(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manager = appDelegate.persistentContainer.viewContext
    }
    
    
    func insertFavLeague(leagueInserted: League){
        let entity = NSEntityDescription.entity(forEntityName: "MyLeague", in: manager)
        let league = NSManagedObject(entity: entity!, insertInto: manager)
        league.setValue(leagueInserted.sport, forKey: "sport")
        league.setValue(leagueInserted.league_name, forKey: "league_name")
        league.setValue(leagueInserted.league_key, forKey: "league_key")
        league.setValue(leagueInserted.league_logo, forKey: "league_logo")
        league.setValue(leagueInserted.league_year, forKey: "league_year")
        league.setValue(leagueInserted.country_name, forKey: "country_name")
        league.setValue(leagueInserted.country_key, forKey: "country_key")
        league.setValue(leagueInserted.country_logo, forKey: "country_logo")

        do{
            try manager.save()
            print("League Saved!")
        }catch let error{
            print(error.localizedDescription)
        }

    }

    func getStoredLeagues() -> [League]{
        var leagues = [League]()
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "MyLeague")

        do{
            leaguesArr = try manager.fetch(fetch)
            if(leaguesArr.count > 0){
                leagueToBeDeleted = leaguesArr.first
            }

            for i in leaguesArr{
                let myLeague = League()
                myLeague.sport = i.value(forKey: "sport") as? String
                myLeague.league_year = i.value(forKey: "league_year") as? String
                myLeague.league_logo = i.value(forKey: "league_logo") as? String
                myLeague.league_key = i.value(forKey: "league_key") as? Int
                myLeague.league_name = i.value(forKey: "league_name") as? String
                myLeague.country_logo = i.value(forKey: "country_logo") as? String
                myLeague.country_key = i.value(forKey: "country_key") as? Int
                myLeague.country_name = i.value(forKey: "country_name") as? String
                leagues.append(myLeague)
            }

        }catch let error{
            print(error.localizedDescription)
        }

        return leagues

    }

    
    func deleteFavLeague(league : League){

        for i in leaguesArr{
            if ((i.value(forKey: "league_name") as! String) == league.league_name){

               leagueToBeDeleted = i
            }
        }

        guard let league1 = leagueToBeDeleted else{
            print("cannot be deleted!")
            return
        }
        manager.delete(league1)
        do{
            try manager.save()
            print("FavLeague Deleted!")
            leagueToBeDeleted = nil
        }catch let error{
            print(error.localizedDescription)
            print("FavLeague not deleted!!")
        }
    }


    func isLeagueExist(league : League) -> Bool{

        let fetch = NSFetchRequest<NSManagedObject>(entityName: "MyLeague")
        let predicate = NSPredicate(format: "league_key == %i", league.league_key ?? 0)

        fetch.predicate = predicate
        
        do{
            leaguesArr = try manager.fetch(fetch)
            if(leaguesArr.count > 0){
                print("Fav is exist")
                return true
            }else{
                print("Fav is Not exist")
                return false
            }


        }catch let error{
            print(error.localizedDescription)
        }

        return false
    }
    
    
    
}
