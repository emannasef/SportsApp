//
//  LeaguesViewModel.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import Foundation

class LeaguesViewModel {
    
    var bindResultToView : (()->()) = {}
    
    var res :[League]! {
        didSet{
            bindResultToView()
        }
    }
    
    var apiFetchHandler : APIFetchProtocol!
    var mySport : String!
    
    init(apiFetchHandler: APIFetchProtocol!,mySport:String) {
        self.apiFetchHandler = apiFetchHandler
        self.mySport = mySport

    }
    
//    func getData (){
//
//        apiFetchHandler.getLeaguesData(fromSport: mySport) { [weak self] (root: Root?) in
//            self?.res = root?.result
//
//        }
//    }
    
    
    func getLeagueURL()->String{
        return Constants.bseUrl+mySport+Constants.apiKey
    }
    
    func getData (){
        apiFetchHandler.fetchData(url: getLeagueURL()) { [weak self] (root:Root?, err) in
            self?.res = root?.result
        }
    }
    
}
