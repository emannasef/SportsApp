//
//  TeamDetailsViewModel.swift
//  Sports
//
//  Created by Mac on 22/05/2023.
//

import Foundation
class TeamDetailsViewModel {
    
    var bindResultToView : (()->()) = {}
    
    var res :[ResultTeams]! {
        didSet{
            bindResultToView()
        }
    }
    
    var apiFetchHandler : APIFetchProtocol!
    var mySport : String!
    var teamId : String!
    
    init(apiFetchHandler: APIFetchProtocol!,mySport:String,teamId:String) {
        self.apiFetchHandler = apiFetchHandler
        self.mySport = mySport
        self.teamId = teamId
        
    }
    
//    func getData (){
//        apiFetchHandler.getTeamDetails(teamId: teamId, sport: mySport) { res in
//            self.res = res
//        }
//
//    }
    
    func teamURL()->String{
        return Constants.bseUrl+mySport+"&teamId="+teamId+Constants.apiKey
    }
    
    
    func getData(){
        apiFetchHandler.fetchData(url: teamURL()) { [weak self] (root:TeamRoot?, err) in
            self?.res = root?.result
        }
    }
    
}
