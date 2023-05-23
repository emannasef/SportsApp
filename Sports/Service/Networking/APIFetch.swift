//
//  APIFetchHandler.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import Foundation
import Alamofire

class APIFetch : APIFetchProtocol{
    
    func fetchData<T:Codable>(url:String,complition : @escaping (T?,Error?) -> () ){
        
        print("#$%#ResURL",url)
        
                AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
                    switch response.result{
                    case .success(let data):
                      do{
                          let jsonData = try JSONDecoder().decode(T.self, from: data!)
                          complition(jsonData,nil)
                       //   debugPrint(jsonData)
                     } catch {
                        print(error.localizedDescription)
                     }
                   case .failure(let error):
                     print(error.localizedDescription)
                      complition(nil,error)
                    }
                }
        
    }
    
//    func getLeaguesData<T:Codable>(fromSport:String ,complition : @escaping (T?) -> ()){
//
//        let url = Constants.bseUrl+fromSport+Constants.apiKey
//
//      print(url)
//
//      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
//        .response{ resp in
//            switch resp.result{
//              case .success(let data):
//                do{
//                  let jsonData = try JSONDecoder().decode(T.self, from: data!)
//                    complition(jsonData)
//                   // debugPrint(jsonData)
//               } catch {
//                  print(error.localizedDescription)
//               }
//             case .failure(let error):
//               print(error.localizedDescription)
//                complition(nil)
//             }
//        }
//
//   }
//
//
//    func getUpComming( leagueId:String,sport:String,complition: @escaping ([LeagueDetails]) -> ()) {
//
//
//        let url = Constants.bseUrl+sport+"&leagueId="+leagueId+"&from="+Utlies.currentTime+"&to="+Utlies.futureTime+Constants.apiKey
//
//        print("##############UpCommingResURL",url)
//
//        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
//            switch response.result{
//            case .success(let data):
//              do{
//                let jsonData = try JSONDecoder().decode(LeagueRoot.self, from: data!)
//                  complition(jsonData.result ?? [])
//               //   debugPrint(jsonData)
//             } catch {
//                print(error.localizedDescription)
//             }
//           case .failure(let error):
//             print(error.localizedDescription)
//              complition([])
//            }
//        }
//    }
//
//
//    func getLatestResult( leagueId:String,sport:String,complition: @escaping ([LeagueDetails]) -> ()) {
//
//
//        let url = Constants.bseUrl+sport+"&leagueId="+leagueId+"&from="+Utlies.pastTime+"&to="+Utlies.myCurrentTime+Constants.apiKey
//
//        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^LatestResURL",url)
//
//        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
//            switch response.result{
//            case .success(let data):
//              do{
//                let jsonData = try JSONDecoder().decode(LeagueRoot.self, from: data!)
//                  complition(jsonData.result ?? [])
//               //   debugPrint(jsonData)
//             } catch {
//                print(error.localizedDescription)
//             }
//           case .failure(let error):
//             print(error.localizedDescription)
//              complition([])
//            }
//        }
//    }
//
//
//    func getTeamDetails( teamId:String,sport:String,complition: @escaping ([ResultTeams]) ->()){
//
//        let url = Constants.bseUrl+sport+"&teamId="+teamId+Constants.apiKey
//
//        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^TeamURL",url)
//
//        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
//            switch response.result{
//            case .success(let data):
//              do{
//                let jsonData = try JSONDecoder().decode(TeamRoot.self, from: data!)
//                  complition(jsonData.result ?? [] )
//                  //debugPrint(jsonData)
//             } catch {
//                print(error.localizedDescription)
//             }
//           case .failure(let error):
//             print(error.localizedDescription)
//              complition([])
//            }
//        }
//    }
    
}
