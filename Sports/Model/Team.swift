//
//  Team.swift
//  Sports
//
//  Created by Mac on 21/05/2023.
//

import Foundation



class Team {
    var team_key : Int?
    var team_name : String?
    var team_logo : String?

    init(team_key: Int? = nil, team_name: String? = nil, team_logo: String? = nil) {
        self.team_key = team_key
        self.team_name = team_name
        self.team_logo = team_logo
    }
}


struct TeamRoot : Codable {
    let success: Int?
    let result: [ResultTeams]?
}

struct ResultTeams  : Codable{
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    let players: [Player]?
    let coaches: [Coach]?
}


struct Coach : Codable {
    let coach_name: String?
    let coachCountry, coachAge: String?
}


struct Player : Codable{
    let playerKey: Int?
    let player_name, playerNumber: String?
    let playerCountry: String?
    let playerType: PlayerType?
    let playerAge, playerMatchPlayed, playerGoals, playerYellowCards: String?
    let playerRedCards: String?
    let player_image: String?
}

enum PlayerType : Codable {
    case defenders
    case forwards
    case goalkeepers
    case midfielders
}
