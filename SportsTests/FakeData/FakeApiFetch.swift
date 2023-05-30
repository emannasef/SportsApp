//
//  FakeApiFetch.swift
//  SportsTests
//
//  Created by Mac on 23/05/2023.
//

import Foundation
@testable import Sports
class FakApiFetch{
    
    var haveAnError: Bool?
    var fakeData:[String:Any] = [
        "league_key": 4,
        "league_name": "UEFA Europa League",
        "country_key": 1,
        "country_name": "eurocups",
        "league_logo": "https://apiv2.allsportsapi.com//logo//logo_leagues//28_world-cup.png",
        "country_logo": "https://apiv2.allsportsapi.com//logo//logo_country//8_worldcup.png"
      ]
    
    init(haveAnError: Bool? = nil) {
        self.haveAnError = haveAnError
    }
    
    
    enum ResponseWithError : Error {
        case responseError
    }
}

extension FakApiFetch {
   
    func fetchData(url: String, complition: @escaping ([String:Any]?, Error?) -> ()){
        if haveAnError == true{
            complition(nil , ResponseWithError.responseError)
        }else{
           complition(fakeData,nil)
        }
    }
    
}
