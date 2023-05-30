//
//  LeagueDetails.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import Foundation

struct LeagueRoot: Codable{
    let success: Int?
    let result: [LeagueDetails]?
}



struct LeagueDetails:Codable{
    
    let event_key: Int?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let home_team_key: Int?
    let home_team_logo:String?
    let event_away_team: String?
    let away_team_key: Int?
    let away_team_logo: String?
    let  event_final_result : String?
    
//    let country_name:String?
//    let league_name: String?
//    let league_key: Int?
//    let event_stadium: String?
//    let league_logo:String?
//    let country_logo: String?
//    let goalscorers : [GoalScore]?
    
}

//class GoalScore : Codable{
//    let time: String?
//    let home_scorer:String?
//    let home_scorer_id:String?
//    let home_assist:String?
//    let home_assist_id:String?
//    let score:String?
//    let away_scorer:String?
//    let away_scorer_id:String?
//    let away_assist:String?
//    let away_assist_id:String?
//}






