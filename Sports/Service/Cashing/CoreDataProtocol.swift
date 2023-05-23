//
//  CoreDataProtocol.swift
//  Sports
//
//  Created by Mac on 22/05/2023.
//

import Foundation

protocol MyCorDataProtocol {
    func insertFavLeague(leagueInserted: League)
    func getStoredLeagues() -> [League]
    func deleteFavLeague(league : League)
    func isLeagueExist(league : League) -> Bool
    
}
