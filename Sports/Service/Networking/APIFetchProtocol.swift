//
//  APIFetchProtocol.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import Foundation

protocol APIFetchProtocol {
    
    func fetchData<T:Codable>(url:String,complition : @escaping (T?,Error?) -> () )
    
//    func getLeaguesData<T:Codable>( fromSport:String,complition : @escaping (T?) -> () )
//
//    func getUpComming(leagueId:String,sport:String,complition : @escaping ([LeagueDetails]) -> () )
//
//    func getLatestResult(leagueId:String,sport:String,complition : @escaping ([LeagueDetails]) -> () )
//
//    func getTeamDetails( teamId:String,sport:String,complition: @escaping ([ResultTeams]) ->())
    
    
    
}
