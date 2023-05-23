//
//  Leagues.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import Foundation

class Root : Codable {
    var success : Int?
    var result : [League]
}

class League:Codable{
    //football-basketball-tennis-cricket
    
    var league_key:Int?
    var league_name : String?
    var country_key :Int?        //not available for cricket
    var country_name :String?    //not available for cricket
    
    var league_year :String?  // only available for cricket
    var league_logo  :String?  //only available for football
    var country_logo  :String?  //only available for football
    var sport:String?
    enum CodingKeys: String, CodingKey{
        case league_key = "league_key"
        case league_name = "league_name"
        case country_key = "country_key"
        case country_name = "country_name"
        case league_logo = "league_logo"
        case country_logo = "country_logo"
        case league_year = "league_year"
    }
    
}
