//
//  LeagueDetailsViewModel.swift
//  Sports
//
//  Created by Mac on 20/05/2023.
//

import Foundation


class LeagueDetailsViewModel{
    
    var apiFetchHandler : APIFetchProtocol!
    var myId : String!
    var sport :String!
    
    
    var bindResultToView : (()->()) = {}
    var bindLatestToView : (()->()) = {}
    
    var res :[LeagueDetails]! {
        didSet{
            bindResultToView()
        }
    }
    
    var latestRes :[LeagueDetails]! {
        didSet{
            bindLatestToView()
        }
    }
    
    init(apiFetchHandler: APIFetchProtocol!,myId:String,sport:String) {
        self.apiFetchHandler = apiFetchHandler
        self.myId = myId
        self.sport = sport
    }
    
    
//    func getUpcomingEvents(){
//        apiFetchHandler.getUpComming(leagueId: myId, sport: sport) { myRsult in
//            self.res = myRsult
//        }
//    }
    
    
    func upCommingURL()->String{
        return Constants.bseUrl+sport+"&leagueId="+myId+"&from="+Utlies.currentTime+"&to="+Utlies.futureTime+Constants.apiKey

    }
    
    
    func getUpcomingEvents(){
        apiFetchHandler.fetchData(url:upCommingURL()) { (myRes : LeagueRoot?, err) in
            self.res = myRes?.result ?? []
        }
    }
    
    
    
//    func getLatestEvents(){
//        apiFetchHandler.getLatestResult(leagueId: myId, sport: sport) { myRes in
//            self.latestRes = myRes
//        }
//    }
    
    func latestURL()->String{
         return Constants.bseUrl+sport+"&leagueId="+myId+"&from="+Utlies.pastTime+"&to="+Utlies.myCurrentTime+Constants.apiKey
    }
    
    func getLatestEvents(){
        
        apiFetchHandler.fetchData(url: latestURL()) { [weak self] (myRes : LeagueRoot?, err) in
            self?.latestRes = myRes?.result ?? []
        }
    }
 
  
    
}
