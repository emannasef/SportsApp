//
//  FavViewModel.swift
//  Sports
//
//  Created by Mac on 22/05/2023.
//

import Foundation

class FavViewModel {
    
    var myCoreData:MyCorDataProtocol!
  
    var bindResultToView : (()->()) = {}
    
    var favArray:[League]!
    
    init( myCoreData: MyCorDataProtocol!) {
        
        self.myCoreData = myCoreData
    }
    
    func getSoredFavs() -> [League]{
       return myCoreData.getStoredLeagues()
    }
    

    func deleteFavLeague(league:League){
        myCoreData.deleteFavLeague(league: league)
    }
    
    
    func insertFavLeague(league:League){
        myCoreData.insertFavLeague(leagueInserted: league)
    }
    
    func isLeagueExist(league:League)->Bool{
        return myCoreData.isLeagueExist(league: league)
    }
    
}
